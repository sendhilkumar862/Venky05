import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../product/base/view/base_view.dart';
import '../../../custom/choice/choice.dart';
import '../../../product/constants/colors/app_colors_constants.dart';
import '../../../product/extension/colors_extension.dart';
import '../viewModel/preference_view_model.dart';

class PreferenceView extends StatefulWidget {
  const PreferenceView({super.key});

  @override
  State<PreferenceView> createState() => _PreferenceViewState();
}

class _PreferenceViewState extends State<PreferenceView> with TickerProviderStateMixin {

  List<String> choicesValue = [];
  late final AnimationController _controller;
  final choicesMemoizer = AsyncMemoizer<List<dynamic>>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setChoicesValue(List<String> value) {
    setState(() => choicesValue = value);
  }

  Future<List<dynamic>> getChoices() async {
    try {
      const url = "https://randomuser.me/api/?inc=name,picture,email&results=5";
      final res = await Dio().get(url);
      final data = res.data['results'];
      return Future.value(data);
    } on DioException catch (e) {
      throw ErrorDescription(e.message ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PreferenceViewModel>(
      viewModel: PreferenceViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (context, value) =>  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<List<dynamic>>(
      initialData: const [],
      future: choicesMemoizer.runOnce(getChoices),
      builder: (context, snapshot) {
        final choices = snapshot.data ?? [];
        return Scaffold(
          appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Customization', style: TextStyle(color: AppColors.secondaryColor),),
      ),
          body: SingleChildScrollView(
          child: Column(children: <Widget>[ 
            const SizedBox(height: 10,),
             const Center(child: Text('Customization', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),),),
              Padding(padding: const EdgeInsets.all(15),
       child: 
       ListTile(
        contentPadding: const EdgeInsets.all(15),
    tileColor:HexColor('#F0F5FF'),
                leading:  Lottie.asset(
            'assets/animations/building_animation.json',
            controller: _controller,
            onLoaded: (LottieComposition composition) {
              _controller.duration = composition.duration;
              _controller.repeat();
            },
          ),
                title: const Text('Customize your education journey now!', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
               
                subtitle: const 
                    Text('Tailor your education journey by selecting preferences for a personalized experience'),
                    
            
    
              ),
              ),
              const Padding(padding: EdgeInsets.all(10), child:    Row(children: [
                 Text('Grade', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                 Text('Select 1 or more', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),),
              ],),),
           
           
          Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: InlineChoice<String>(
          clearable: true,
          loading: snapshot.connectionState == ConnectionState.waiting,
          value: choicesValue,
          onChanged: setChoicesValue,
          itemCount: choices.length,
          itemBuilder: (selection, i) {
            final choice = choices.elementAt(i);
            final value = choice['email'];
            final label =
                choice['name']['first'] + ' ' + choice['name']['last'];
            // final avatar = choice['picture']['thumbnail'];
            return ChoiceChip(
              selected: selection.selected(value),
              onSelected: selection.onSelected(value),
              showCheckmark: false,
              // avatar: CircleAvatar(
              //   backgroundImage: NetworkImage(avatar),
              // ),
              label: Text(label),
            );
          },
          listBuilder: ChoiceList.createWrapped(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),
          ),
        ),
            ),
          ),
          
        ),
        
     
         TextButton(
                  onPressed: () {},
                  child: Container(
                    color: const Color.fromARGB(255, 3, 111, 199),
                    // height: 40,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: const Text(
                      'Save  Preference',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ),
                ),
         
        ],
        )
         
      ),
    );
        
        
       
      },
    ),
    ),
    );
  }
}

