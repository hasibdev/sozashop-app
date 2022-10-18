import 'package:dio/dio.dart';
import 'package:sozashop_app/data/http/dio_client.dart';

class CategoryService {
  final DioClient _dioClient = DioClient();

  Future getCategories(
      {required int pageNo, required int perPage, String? searchText}) async {
    var response = await _dioClient.get(
        endPoint:
            "/categories?page=$pageNo&search=$searchText&perPage=$perPage&sort=id,desc");
    return response;
  }

  // add category
  Future addCategory(categoryName, description) async {
    Response response = await _dioClient.post(
      endPoint: '/categories',
      data: {
        "categoryName": categoryName,
        "description": description,
      },
    );
    return response;
  }

  Future deleteCategory(int id) async {
    var response = await _dioClient.delete(endPoint: "/categories/$id");
    return response;
  }

  // edit Category
  Future editCategory(int id, name, description, status) async {
    Response response = await _dioClient.update(
      endPoint: '/categories/$id',
      data: {
        "name": name,
        "description": description,
        "status": status,
      },
    );
    return response;
  }
}
