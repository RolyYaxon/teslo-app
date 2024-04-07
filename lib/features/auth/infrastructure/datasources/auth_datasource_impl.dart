import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

class AuthDatasourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(baseUrl: Enviroment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get("/auth/check-status",
          options: Options(headers: 
          {"Authorization": "Bearer $token"}));

      final user = UserMapper.userJstonToEntity(response.data);
      return user; 
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError("Token no valido");
      }
      if (e.type == DioExceptionType.connectionError) {
        throw CustomError("Revisar internet");
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio
          .post("/auth/login", data: {"email": email, "password": password});

      final user = UserMapper.userJstonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data["message"] ?? "Credenciales incorrectas");
      }
      if (e.type == DioExceptionType.connectionError) {
        throw CustomError("Revisar internet");
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
