import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/custom_widgets/common_container.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';
import 'package:provider/provider.dart';
import 'package:krishi_connect/provider/farmer_provider.dart';
import 'package:krishi_connect/provider/admin_provider.dart';
import 'package:krishi_connect/repo/api.dart';

class AdminSchemesScreen extends StatelessWidget {
  const AdminSchemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farmer = context.watch<FarmerProvider>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openSchemeForm(context),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: farmer.schemes.length,
        itemBuilder: (_, i) {
          final scheme = farmer.schemes[i];
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: CommonContainer(
              child: ListTile(
                title: Text(scheme.title),
                subtitle: Text(scheme.link),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _openSchemeForm(context, scheme: scheme),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: context.colorTheme.error),
                      onPressed: () => _confirmDelete(context, () async {
                        await context.read<AdminProvider>().deleteScheme(
                          scheme.id,
                        );
                        await context.read<FarmerProvider>().loadSchemes();
                      }),
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

  void _openSchemeForm(BuildContext context, {GovernmentScheme? scheme}) {
    final title = TextEditingController(text: scheme?.title);
    final link = TextEditingController(text: scheme?.link);
    final imageUrl = TextEditingController(text: scheme?.imageUrl);
    final description = TextEditingController(text: scheme?.description);
    final region = TextEditingController(text: scheme?.region);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
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
              scheme == null ? "Add Scheme" : "Edit Scheme",
              style: context.textTheme.titleLarge,
            ),
            30.verticalSpace,
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            20.verticalSpace,
            TextField(
              controller: link,
              decoration: const InputDecoration(labelText: "Link"),
            ),
            20.verticalSpace,
            TextField(
              controller: imageUrl,
              decoration: const InputDecoration(labelText: "Image Url"),
            ),
            20.verticalSpace,
            TextField(
              controller: region,
              decoration: const InputDecoration(labelText: "Region"),
            ),
            20.verticalSpace,
            TextField(
              controller: description,
              minLines: 3,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: "Description",
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final admin = context.read<AdminProvider>();
                final farmer = context.read<FarmerProvider>();

                if (scheme == null) {
                  await admin.createScheme(
                    GovernmentSchemeCreate(
                      title: title.text,
                      link: link.text,
                      description: description.text,
                      imageUrl: imageUrl.text,
                      region: region.text,
                    ),
                  );
                } else {
                  await admin.updateScheme(
                    scheme.id,
                    GovernmentSchemeUpdate(
                      title: title.text,
                      link: link.text,
                      description: description.text,
                      imageUrl: imageUrl.text,
                      region: region.text,
                    ),
                  );
                }

                await farmer.loadSchemes();
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure?"),
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
