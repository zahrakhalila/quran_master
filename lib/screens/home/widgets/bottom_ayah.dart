part of '../home_screen.dart';

class _AyahBottom extends StatelessWidget {
  const _AyahBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "\"Read the Qur'an, because indeed it will be an\n intercessor for its readers on the Day of Judgment\"",
            textAlign: TextAlign.center,
            style: AppText.b2!.copyWith(
              color: AppTheme.c!.text,
            ),
          ),
          Space.y!,
          Text(
            "HR Muslim\n",
            style: AppText.l1!.copyWith(
              color: AppTheme.c!.text,
            ),
          ),
        ],
      ),
    );
  }
}
