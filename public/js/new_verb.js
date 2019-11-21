function addObjectOrType () {
  var name = document.createElement("DIV");
  var class_or_string = document.createElement("DIV");
  var objects_or_types = document.getElementById("objects_or_types");
  var order = (objects_or_types.childNodes.length + 1) / 2;
  name.className = "col-sm-3";
  class_or_string.className = "col-sm-3";
  name.innerHTML = '<label class="text-light">Object Name</label>' +
  '<input class="form-control" type="text" name="object_name[]">';
  class_or_string.innerHTML = '<label class="text-light">Class Or String</label>' +
  '<select class="form-control" name="class_or_string[]">' +
  '<option value="string" selected>String</option>' +
  '<option value="class">Class</option>' + '</select>' +
  '<input type="hidden" name="object_order[]" value="' + order + '">';
  objects_or_types.appendChild(name);
  objects_or_types.appendChild(class_or_string);
  var remove_object = document.getElementById("remove_object");
  if(getComputedStyle(remove_object,null).display == "none") {
    remove_object.style.display = "inline";
  }
}
function removeObjectOrType () {
  var objects_or_types = document.getElementById("objects_or_types");
  var length = objects_or_types.childNodes.length
  if (length > 1) {
    objects_or_types.removeChild(objects_or_types.childNodes[length - 1]);
    objects_or_types.removeChild(objects_or_types.childNodes[length - 2]);
  }
  if(objects_or_types.childNodes.length == 1) {
    document.getElementById("remove_object").style.display = "none";
  };
}
