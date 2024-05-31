

class Endpoints {
  static const baseUrl = 'http://192.168.189.2:5066';

  static const addressOfHouses = '/api/addressOfHouses';
  static const getAll = '/api/application/getall';
  static const getAllCity = '/api/application/getAllCity';
  static const getByUserGuid = '/api/application/getByUserGuid?userGuid={userGuid}&UserRoleName={UserRoleName}';
  static const createApplication = '/api/application/create';
  static const updateState = '/api/application/updatestate';

  static const cities = '/cities/{regionId}';
  static const getCountries = '/api/countries';
  static const createCountry= '/api/updatestate';


  static const register = '/register';
  static const login = '/login';
  static const authorizeByRefreshToken = '/refresh-token';

  static const getDistrict = '/api/microDistrict/{districtId}';
  static const getRegion = '/api/region/{countryId}';
  static const getStreet = '/api/streets/{districtId}';

  static const getUserInfo = '/api/userinfo';
  static const createUserInfo = '/api/userinfo';
  static const getUserInfoByGuid = '/api/userinfo/{userGuid}';
}