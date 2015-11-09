import 'package:shelf_auth/shelf_auth.dart';
import 'dart:io';
import 'package:rpc/rpc.dart';
import '../model/model.dart';

class User extends Principal {
  MDTUser dbUser;
  User(MDTUser user ):super(user.email){
     this.dbUser = user;
  }
}

class Response {
  int status;
  Map<String,String> data;
  Response(this.status,this.data);
}

class ResponseList {
  int status;
  List<Map<String,String>> list;
  ResponseList(this.status,this.list);
}

class OKResponse extends Response {
  OKResponse():super(200,{});
}

class NotApplicationAdministrator extends RpcError {
  NotApplicationAdministrator():super(401, 'Forbidden', 'You are not administrator on this app');
}

class ArtifactMsg {
  @ApiProperty(required: true)
  MediaMessage file;
}

// request message
class BaseArtifactMsg {
  @ApiProperty(required: true)
  String version;
  @ApiProperty(required: true)
  String artifactName;
}

class ArtifactMsg1 extends BaseArtifactMsg {
  @ApiProperty(required: true)
  MediaMessage file;
  @ApiProperty(required: true)
  String branch;
  @ApiProperty(required: false)
  String sortIdentifier;
  @ApiProperty(required: false)
  String tags;
  ArtifactMsg();
}