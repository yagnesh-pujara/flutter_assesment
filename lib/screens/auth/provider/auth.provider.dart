import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_assesment/constants/preference_keys.dart';
import 'package:flutter_assesment/screens/auth/model/country_list.model.dart';
import 'package:flutter_assesment/screens/auth/model/login_response.model.dart';
import 'package:flutter_assesment/screens/auth/model/resend_error.model.dart';
import 'package:flutter_assesment/screens/auth/model/terms_and_conditions.model.dart';
import 'package:flutter_assesment/screens/auth/model/verify_otp.model.dart';
import 'package:flutter_assesment/screens/home/model/common_response.model.dart';
import 'package:flutter_assesment/screens/home/model/country_selection.model.dart' hide Country;
import 'package:flutter_assesment/utils/api_endpoints.dart';
import 'package:flutter_assesment/utils/preference_manager.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool termsLoading = true;
  TermsAndConditionsModel? terms;
  CommonResponse? termsError;
  Future<void> getTermsAndConditions() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.BASEURL}${ApiEndpoints.getTerms}'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        terms = TermsAndConditionsModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 400) {
        termsError = CommonResponse.fromJson(json.decode(response.body));
      }

      termsLoading = false;
      notifyListeners();
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      termsLoading = false;
      notifyListeners();
    }
  }

  CountryListResponse? countryListResponse;
  bool countryListLoading = true;
  CommonResponse? countryListError;
  Future<void> fetchCountries() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.BASEURL}${ApiEndpoints.getCountry}'),
        headers: {
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        countryListResponse = CountryListResponse.fromJson(json.decode(response.body));
        for (int i = 0; i < limit; i++) {
          country.add(countryListResponse!.data![i]);
        }
      } else if (response.statusCode == 400) {
        countryListError = CommonResponse.fromJson(json.decode(response.body));
      }
      countryListLoading = false;
      notifyListeners();
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      countryListLoading = false;
      notifyListeners();
    }
  }

  final int limit = 30;
  List<Country> country = [];
  bool isStudent = false;
  Country? selectedCountry;
  String mobile = "";

  bool userLoginLoading = true;
  UserLoginResponse? userLoginResponse;
  CommonResponse? userLoginError;
  Future<void> userLogin(String mobile) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.BASEURL}${ApiEndpoints.studentLogin}'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'tel_code': selectedCountry!.telCode,
          'phone': mobile,
        },
      );
      if (response.statusCode == 200) {
        userLoginResponse = UserLoginResponse.fromJson(json.decode(response.body));
        PreferenceManager.saveString(PrefKeys.PHONE_WITH_CODE, userLoginResponse!.data!.phone!);
      } else if (response.statusCode == 400) {
        userLoginError = CommonResponse.fromJson(json.decode(response.body));
      }
      userLoginLoading = false;
      notifyListeners();
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      userLoginLoading = false;
      notifyListeners();
    }
  }

  bool verifyOtpLoading = true;
  VerifyOtpResponse? verifyOtpResponse;
  CommonResponse? verifyOtpError;
  Future<void> verifyOtp(String otp) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.BASEURL}${ApiEndpoints.verifyOtp}'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'code': otp,
          'phone': PreferenceManager.getString(PrefKeys.PHONE_WITH_CODE),
        },
      );
      if (response.statusCode == 200) {
        verifyOtpResponse = VerifyOtpResponse.fromJson(json.decode(response.body));
        PreferenceManager.saveString(PrefKeys.AUTH_TOCKEN, verifyOtpResponse!.data!.accessToken!);
      } else if (response.statusCode == 400) {
        verifyOtpError = CommonResponse.fromJson(json.decode(response.body));
      }
      verifyOtpLoading = false;
      notifyListeners();
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      verifyOtpLoading = false;
      notifyListeners();
    }
  }

  UserLoginResponse? resendUserResponse;
  bool resendOtpLoading = true;
  ResendErrorResponse? resendError;
  CommonResponse? commonError;
  Future<void> resendOtp() async {
    try {
      final mobile = PreferenceManager.getString(PrefKeys.PHONE_WITH_CODE);
      final response = await http.post(
        Uri.parse('${ApiEndpoints.BASEURL}${ApiEndpoints.resendOtp}'),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'phone': mobile.toString(),
        },
      );
      if (response.statusCode == 200) {
        resendUserResponse = UserLoginResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 400) {
        resendError = ResendErrorResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 403) {
        commonError = CommonResponse.fromJson(json.decode(response.body));
      }
      resendOtpLoading = false;
      notifyListeners();
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      resendOtpLoading = false;
      notifyListeners();
    }
  }

  SelectCountryResponse? studyCountrySelection;
  bool studyCountryLoading = true;
  CommonResponse? studyCountryError;
  Future<void> getStudyCountries() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.BASEURL}${ApiEndpoints.selectCountry}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${PreferenceManager.getString(PrefKeys.AUTH_TOCKEN)}',
        },
      );
      if (response.statusCode == 200) {
        studyCountrySelection = SelectCountryResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 400) {
        studyCountryError = CommonResponse.fromJson(json.decode(response.body));
      }
      studyCountryLoading = false;
      notifyListeners();
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      studyCountryLoading = false;
      notifyListeners();
    }
  }

  SelectCountryResponse? selectCountryResponse;
  bool selectCountry = true;
  CommonResponse? selectCountryError;
  Future<void> setStudyCountry(int id) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.BASEURL}${ApiEndpoints.selectCountry}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${PreferenceManager.getString(PrefKeys.AUTH_TOCKEN)}',
        },
        body: {
          'country_id': id.toString(),
        },
      );
      if (response.statusCode == 200) {
        selectCountryResponse = SelectCountryResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 400) {
        selectCountryError = CommonResponse.fromJson(json.decode(response.body));
      }
      selectCountry = false;
      notifyListeners();
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      selectCountry = false;
      notifyListeners();
    }
  }

  bool logoutUserLoading = true;
  CommonResponse? logoutResponse;
  CommonResponse? logoutErrorResponse;
  Future<void> logoutUser() async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.BASEURL}${ApiEndpoints.logout}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${PreferenceManager.getString(PrefKeys.AUTH_TOCKEN)}',
        },
      );
      if (response.statusCode == 200) {
        logoutResponse = CommonResponse.fromJson(json.decode(response.body));
        PreferenceManager.saveString(PrefKeys.AUTH_TOCKEN, verifyOtpResponse!.data!.accessToken!);
      } else if (response.statusCode == 400) {
        logoutErrorResponse = CommonResponse.fromJson(json.decode(response.body));
      }
      logoutUserLoading = false;
      notifyListeners();
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      logoutUserLoading = false;
      notifyListeners();
    }
  }

  bool deleteUserLoading = true;
  CommonResponse? deleteUserResponse;
  CommonResponse? deleteUserError;
  Future<void> deleteUser() async {
    try {
      final response = await http.post(
        Uri.parse('${ApiEndpoints.BASEURL}${ApiEndpoints.delete}'),
        headers: {'Accept': 'application/json', 'Authorization': 'Bearer ${PreferenceManager.getString(PrefKeys.AUTH_TOCKEN)}'},
      );
      if (response.statusCode == 200) {
        deleteUserResponse = CommonResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 400) {
        deleteUserError = CommonResponse.fromJson(json.decode(response.body));
      }
      deleteUserLoading = false;
      notifyListeners();
    } on Exception catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      deleteUserLoading = false;
      notifyListeners();
    }
  }
}
