import 'package:cs_weather/model/weather_data_model.dart';
import 'package:cs_weather/viewModel/weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomepageMobileView extends StatefulWidget {
  const HomepageMobileView({Key? key}) : super(key: key);

  @override
  State<HomepageMobileView> createState() => _HomepageMobileViewState();
}

class _HomepageMobileViewState extends State<HomepageMobileView> {
  final WeatherViewModel weatherViewModel = WeatherViewModel();
  WeatherDataModel weatherDataModel = WeatherDataModel();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(1080, 1920));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Text('N: API provides only US and Germany weather data.', style: TextStyle(fontSize: 25.sp, color: Colors.purple),),
              SizedBox(height: 30.h,),
              //to get input latitude
              input(hint: 'Enter latitude', controller: _latitudeController),
              SizedBox(height: 50.h),

              //to get input longitude
              input(hint: 'Enter longitude', controller: _longitudeController),
              SizedBox(height: 50.h,),

              ElevatedButton(
                onPressed: () async {
                  final data = await weatherViewModel.sendRequest(latitude: _latitudeController.text, longitude: _longitudeController.text).catchError((error){
                    _showError(error.toString());
                  });
                  weatherDataModel = WeatherDataModel.fromJson(data);
                  setState(() {
                    weatherDataModel = WeatherDataModel.fromJson(data);
                  });
                },
                child: Text('Get Weather Update', style: TextStyle(fontSize: 45.sp),),
              ),

              SizedBox(height: 90.h),

              //show data
              Text(weatherDataModel.temperatureCurrent == null? '':
                  'Location:  ${weatherDataModel.location}\n'
                  'Current Temperature:  ${weatherDataModel.temperatureCurrent}${weatherDataModel.temperatureUnit}\n'
                  'Maximum Temperature:  ${weatherDataModel.temperatureMax}${weatherDataModel.temperatureUnit}\n'
                  'Minimum Temperature:  ${weatherDataModel.temperatureMin}${weatherDataModel.temperatureUnit}\n'
                  'Condition:  ${weatherDataModel.condition}\n'
                  'Wind Speed:  ${weatherDataModel.windSpeed}${weatherDataModel.windSpeedUnit}\n'
                  'Wind Direction:  ${weatherDataModel.windDirection}', style: TextStyle(fontSize: 40.sp),),
            ],
          ),
        ),
      ),
    );
  }

  Widget input({hint, controller}){
    return SizedBox(
      width: 750.w,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hint,
        ),
      ),
    );
  }
  void _showError(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
