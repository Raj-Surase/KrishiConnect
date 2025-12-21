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
    final nameCtrl = TextEditingController(text: crop?.name);
    final detailsCtrl = TextEditingController(text: crop?.details);
    final imageUrlCtrl = TextEditingController(text: crop?.imageUrl);
    final contextCtrl = TextEditingController(text: crop?.context);

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.verticalSpace,
              Text(
                crop == null ? "Add Crop" : "Edit Crop",
                style: context.textTheme.titleLarge,
              ),
              30.verticalSpace,
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              20.verticalSpace,
              TextField(
                controller: imageUrlCtrl,
                decoration: const InputDecoration(labelText: "Image Url"),
              ),
              20.verticalSpace,
              TextField(
                controller: detailsCtrl,
                minLines: 3,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "Details",
                  alignLabelWithHint: true,
                ),
              ),
              20.verticalSpace,
              TextField(
                controller: contextCtrl,
                minLines: 3,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "Context",
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final admin = context.read<AdminProvider>();
                  final farmer = context.read<FarmerProvider>();

                  if (crop == null) {
                    await admin.createCrop(
                      CropCreate(
                        name: nameCtrl.text,
                        imageUrl: imageUrlCtrl.text,
                        details: detailsCtrl.text,
                        context: contextCtrl.text,
                      ),
                    );
                  } else {
                    await admin.updateCrop(
                      crop.id,
                      CropUpdate(
                        name: nameCtrl.text,
                        imageUrl: imageUrlCtrl.text,
                        details: detailsCtrl.text,
                        context: contextCtrl.text,
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
