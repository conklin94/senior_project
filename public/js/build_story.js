function addCharacter() {
  var name = document.createElement("DIV");
  var gender = document.createElement("DIV");
  var characters = document.getElementById("characters");
  name.className = "col-sm-4";
  gender.className = "col-sm-2";
  name.innerHTML = '<label class="text-light">Name</label>' +
  '<input class="form-control" type="text" name="name[]">';
  gender.innerHTML = '<label class="text-light">Gender</label>' +
  '<select class="form-control" name="gender[]">' +
  '<option value="female" selected>Female</option>' +
  '<option value="male">Male</option>' + '</select>';
  characters.appendChild(name);
  characters.appendChild(gender);

  var remove_char = document.getElementById("remove_character");
  if(getComputedStyle(remove_char,null).display == "none") {
    remove_char.style.display = "inline";
  }
}

// Remove a field for a Character from the form
function removeCharacter() {
  var characters = document.getElementById("characters");
  var length = characters.childNodes.length;
  if (length > 5) {
    characters.removeChild(characters.childNodes[length - 1]);
    characters.removeChild(characters.childNodes[length - 2]);
  }
  if(characters.childNodes.length == 5) {
    document.getElementById("remove_character").style.display = "none";
  };
}

// Add a field for either a place or an item
// variable type should be "place" or "item"
function addValue(type) {
  var div = document.createElement("DIV");
  div.className = "col-sm-4";
  div.innerHTML = '<label class="text-light">' + type[0].toUpperCase() +
  type.slice(1) + '</label>' +
  '<input class="form-control" type="text" name="' + type + '[]">';
  document.getElementById(type + "s").appendChild(div);

  var remove = document.getElementById("remove_" + type);
  if(getComputedStyle(remove,null).display == "none") {
    remove.style.display = "inline";
  }
}

// Removes a field for a place or item
// variable type should be "place" or "item"
function removeValue(type) {
  var values = document.getElementById(type + "s");
  var length = values.childNodes.length;
  if (length > 3) {
    values.removeChild(values.childNodes[length - 1]);
  }
  if (values.childNodes.length == 3) {
    document.getElementById("remove_" + type).style.display = "none";
  }
}

// Get a random integer from 0 to one less than the upper limit
function rand(upper_limit) {
  return Math.floor(Math.random() * upper_limit)
}
