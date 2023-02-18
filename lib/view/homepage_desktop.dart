import 'package:cs_weather/model/weather_data_model.dart';
import 'package:cs_weather/viewModel/weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomepageDesktopView extends StatefulWidget {
  const HomepageDesktopView({Key? key}) : super(key: key);

  @override
  State<HomepageDesktopView> createState() => _HomepageDesktopViewState();
}

class _HomepageDesktopViewState extends State<HomepageDesktopView> {
  final WeatherViewModel weatherViewModel = WeatherViewModel();
  WeatherDataModel weatherDataModel = WeatherDataModel();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(1920, 1080));
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
              Text('N: API provides only US and Germany weather data.', style: TextStyle(fontSize: 23.sp, color: Colors.purple),),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //to get input latitude
                  input(hint: 'Enter latitude', controller: _latitudeController),
                  SizedBox(width: 80.w),

                  //to get input longitude
                  input(hint: 'Enter longitude', controller: _longitudeController),
                ],
              ),

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
                child: Text('Get Weather Update', style: TextStyle(fontSize: 40.sp),),
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
      width: 700.w,
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
