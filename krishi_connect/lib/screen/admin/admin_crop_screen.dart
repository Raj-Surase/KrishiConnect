import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/custom_widgets/common_container.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';
import 'package:provider/provider.dart';
import 'package:krishi_connect/provider/farmer_provider.dart';
import 'package:krishi_connect/provider/admin_provider.dart';
import 'package:krishi_connect/repo/api.dart';

class AdminCropScreen extends StatelessWidget {
  const AdminCropScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farmer = context.watch<FarmerProvider>();

    if (farmer.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCropForm(context),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: farmer.crops.length,
        itemBuilder: (context, index) {
          final crop = farmer.crops[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: CommonContainer(
              child: ListTile(
                leading: crop.imageUrl != null
                    ? Image.network(crop.imageUrl!, height: 40.h, width: 40.w)
                    : Icon(Icons.grass_rounded),
                title: Text(crop.name),
                // subtitle: Text(crop.details ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _openCropForm(context, crop: crop),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: context.colorTheme.error),
                      onPressed: () => _confirmDelete(
                        context,
                        onDelete: () async {
                          await context.read<AdminProvider>().deleteCrop(
                            crop.id,
                          );
                          await context.read<FarmerProvider>().loadCrops();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openCropForm(BuildContext context, {Crop? crop}) {
    final _formKey = GlobalKey<FormState>();

    final nameCtrl = TextEditingController(text: crop?.name);
    final detailsCtrl = TextEditingController(text: crop?.details);
    final imageUrlCtrl = TextEditingController(text: crop?.imageUrl);
    final contextCtrl = TextEditingController(text: crop?.context);

    String? _nameValidator(String? value) {
      if (value == null || value.trim().isEmpty) {
        return "Name is required";
      }
      if (RegExp(r'\d').hasMatch(value)) {
        return "Name should not contain numbers";
      }
      return null;
    }

    String? _urlValidator(String? value) {
      if (value == null || value.trim().isEmpty) {
        return "Image URL is required";
      }
      if (!value.startsWith("https://")) {
        return "URL must start with https://";
      }
      return null;
    }

    String? _detailsValidator(String? value) {
      if (value == null || value.trim().isEmpty) {
        return "Details are required";
      }
      if (!RegExp(r'^[A-Za-z]').hasMatch(value.trim())) {
        return "Details must start with a character";
      }
      return null;
    }

    String? _contextValidator(String? value) {
      if (value == null || value.trim().isEmpty) {
        return "Context is required";
      }
      if (!RegExp(r'^[A-Za-z]').hasMatch(value.trim())) {
        return "Context must start with a character";
      }

      final wordCount = value.trim().split(RegExp(r'\s+')).length;
      if (wordCount < 10) {
        return "Context must be at least 10 words long";
      }
      return null;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.verticalSpace,
                Text(
                  crop == null ? "Add Crop" : "Edit Crop",
                  style: context.textTheme.titleLarge,
                ),
                30.verticalSpace,

                /// Name
                TextFormField(
                  controller: nameCtrl,
                  validator: _nameValidator,
                  decoration: const InputDecoration(labelText: "Name"),
                ),

                20.verticalSpace,

                /// Image URL
                TextFormField(
                  controller: imageUrlCtrl,
                  validator: _urlValidator,
                  decoration: const InputDecoration(labelText: "Image Url"),
                ),

                20.verticalSpace,

                /// Details
                TextFormField(
                  controller: detailsCtrl,
                  validator: _detailsValidator,
                  minLines: 3,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: "Details",
                    alignLabelWithHint: true,
                  ),
                ),

                20.verticalSpace,

                /// Context
                TextFormField(
                  controller: contextCtrl,
                  validator: _contextValidator,
                  minLines: 3,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: "Context",
                    alignLabelWithHint: true,
                  ),
                ),

                const SizedBox(height: 16),

                /// Save Button
                ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final admin = context.read<AdminProvider>();
                    final farmer = context.read<FarmerProvider>();

                    if (crop == null) {
                      await admin.createCrop(
                        CropCreate(
                          name: nameCtrl.text.trim(),
                          imageUrl: imageUrlCtrl.text.trim(),
                          details: detailsCtrl.text.trim(),
                          context: contextCtrl.text.trim(),
                        ),
                      );
                    } else {
                      await admin.updateCrop(
                        crop.id,
                        CropUpdate(
                          name: nameCtrl.text.trim(),
                          imageUrl: imageUrlCtrl.text.trim(),
                          details: detailsCtrl.text.trim(),
                          context: contextCtrl.text.trim(),
                        ),
                      );
                    }

                    await farmer.loadCrops();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, {required VoidCallback onDelete}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
