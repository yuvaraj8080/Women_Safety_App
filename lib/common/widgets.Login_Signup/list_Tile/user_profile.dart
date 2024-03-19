import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/personalization/controllers/user_controller.dart';
import '../../../utils/constants/colors.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final user = controller.user.value;
    return ListTile(
      leading:  CircleAvatar(radius:25,
        backgroundImage:NetworkImage(user.profilePicture.isEmpty? "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png" :user.profilePicture),// Placeholder icon
      ),
      title: Text(
        user.fullName ?? '',
        style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),
      ),
      subtitle: Text(
        user.email ?? '',
        style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: Card(
        color:Colors.white,
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: Colors.blue,size:30),
        ),
      ),
    );
  }
}
