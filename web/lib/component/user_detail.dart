import 'package:angular/angular.dart';
import 'package:angular_ui/angular_ui.dart';
import 'dart:async';
import 'dart:html';
import 'base_component.dart';
import '../service/mdt_query.dart';
import '../model/errors.dart';
import '../model/mdt_model.dart';

//useShadowDom: false
@Component(
    selector: 'tr[is=user_detail]',
    templateUrl: 'user_detail.html'
// use <span> instead of <td> because the browsers drop <td>' not inside a <table>.
// <td>'s are created dynamically when the content is inserted into <tr>
)
class UsersDetail extends ShadowRootAware{
  @NgOneWay('user')
  MDTUser user;

  bool isActivated = false;
  bool isAdmin = false;
  String password;
  String name;

  UsersDetail(){
    print("UsersDetail created");
  }

  void initComponent() {
      name = user.name;
      isActivated = user.isActivated;
      isAdmin = user.isSystemAdmin;
  }

  void updateUser(){

  }

  void resetUser(){
    password = null;
    name = user.name;
    isActivated = user.isActivated;
    isAdmin = user.isSystemAdmin;
  }

  bool get canUpdate => (user.name != name) || (user.isActivated != isActivated) || (user.isSystemAdmin != isAdmin) || password!=null;



  void delete(){

  }

  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    initComponent();
    // get content for table cells (ignore <content> and <style> tags)
    var templateElements = new List<Element>.from(shadowRoot.children.where((e) => !(e is StyleElement) && !(e is ContentElement)));

    // the table cells need to be put into the <content> element to become childs of the table row
    ContentElement ce = shadowRoot.querySelector('content');

    templateElements.forEach((span) {
      // remove from old place before adding to new parent
      span.remove();

      // get the content of a table cell (the future <td> content)
      var cellContent = new List<Node>.from(span.childNodes);

      // remove cell content from span before adding to the table cell
      cellContent.forEach((cc) => cc.remove());
      var td = new TableCellElement();

      cellContent.forEach((cc) => td.append(cc));

      ce.append(td);
    });
  }


}