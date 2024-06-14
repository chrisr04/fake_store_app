part of '../home_page.dart';

class AddressRow extends StatelessWidget {
  const AddressRow({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppConfig>().currentUser;
    final address = user != null
        ? '${user.address.number} ${user.address.street}, ${user.address.city}, ${user.address.zipcode}'
        : '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FakeIcon(
          Icons.location_on_outlined,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const FakeSpacerXS(axis: FakeSpacerAxis.x),
        Flexible(
          child: FakeTextLarge(
            address,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            weight: FontWeight.w600,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
