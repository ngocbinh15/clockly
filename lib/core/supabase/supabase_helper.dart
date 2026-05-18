import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<String> uploadImage<T>({
  required File image,
  required String bucket,
  required String path,
  bool upsert = false,
}) async{
  await supabase.storage.from(bucket).upload(
    path,
    image,
    fileOptions: FileOptions(cacheControl: "3600", upsert: upsert),
  );
  final String publicUrl = supabase.storage.from(bucket).getPublicUrl(path);
  return publicUrl;
}

Future<String> updateImage<T>({
  required File image,
  required String bucket,
  required String path,
  bool upsert = false,
}) async{
  await supabase.storage.from(bucket).upload(
    path,
    image,
    fileOptions: FileOptions(cacheControl: "3600", upsert: upsert),
  );
  final String publicUrl = supabase.storage.from(bucket).getPublicUrl(path);
  return publicUrl + "?ts=${DateTime.now().microsecond}";
}