part of '../home.dart';

class HomeContact extends StatelessWidget {
  const HomeContact({Key? key}) : super(key: key);

  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/Contact',
      builder: (_) => this,
    );
  }

  Widget getLabeledInput({
    required String labelText,
    String? hintText,
    String? defaultValue,
    bool isMultiline = false,
    int? minLines,
    int? maxLines,
    bool readOnly = false,
    void Function(String?)? onSaved
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            labelText,
            style: const TextStyle(fontSize: 13, color: Colors.black),
          ),
        ),
        Material(
          borderRadius: BorderRadius.circular(8),
          elevation: 2,
          child: BlueRoundedTextInput(
            hint: hintText,
            onSaved: onSaved,
            minLines: minLines,
            maxLines: maxLines,
            initialValue: defaultValue,
            readOnly: readOnly,
            textInputType: isMultiline ? TextInputType.multiline : null,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileEmail = context.read<ProfileCubit>().state.profile?.email;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) =>
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 25),
                          const Text(
                            'Contact us for any reason',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          getLabeledInput(
                            labelText: 'From',
                            hintText: 'Email',
                            defaultValue: profileEmail,
                            onSaved: (val) {},
                          ),
                          const SizedBox(height: 16),
                          getLabeledInput(
                            labelText: 'To',
                            readOnly: true,
                            defaultValue: 'info@epc.ae',
                            onSaved: (val) {},
                          ),
                          const SizedBox(height: 16),
                          getLabeledInput(
                            labelText: 'Title',
                            hintText: 'Some Issue',
                            onSaved: (val) {},
                          ),
                          const SizedBox(height: 16),
                          getLabeledInput(
                            labelText: 'Message',
                            isMultiline: true,
                            minLines: 1,
                            maxLines: 4,
                            onSaved: (val) {},
                          ),
                          const SizedBox(height: 16),
                          BlueRoundedButton(
                            text: 'Send',
                            dense: true,
                            onPress: () {},
                          )
                        ]
                    ),
                  ),
                ],
              ),
            ),
          )
    );
  }
}
