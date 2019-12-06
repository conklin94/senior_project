/******************************************************************************
* Show Feedback
* display the region for story feedback on the page
******************************************************************************/
function showFeedback() {
  document.getElementById("give_feedback").className = "d-none";
  document.getElementById("hide_feedback").className = "mt-2 btn btn-light";
  document.getElementById("feedback").className = "bg-white mt-2 mb-5 p-3";
}

/******************************************************************************
* Hide Feedback
* hide the region for story feedback on the page
******************************************************************************/
function hideFeedback() {
  document.getElementById("give_feedback").className = "mt-2 btn btn-light";
  document.getElementById("hide_feedback").className = "d-none";
  document.getElementById("feedback").className = "d-none";
}

/******************************************************************************
* Post Ajax
* Source: https://plainjs.com/javascript/ajax/send-ajax-get-and-post-requests-47/
******************************************************************************/
function postAjax(url, data, success) {
    var params = typeof data == 'string' ? data : Object.keys(data).map(
            function(k){ return encodeURIComponent(k) + '=' + encodeURIComponent(data[k]) }
        ).join('&');

    var xhr = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
    xhr.open('POST', url);
    xhr.onreadystatechange = function() {
        if (xhr.readyState>3 && xhr.status==200) { success(xhr.responseText); }
    };
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(params);
    return xhr;
}

/******************************************************************************
* Submit Feedback
* Use a users feedback to update the weights of the verbs in the database
******************************************************************************/
function submitFeedback() {
  var i = 0;
  var subtract = [];
  var add = [];
  var verb = document.getElementsByName("verb[" + i + "]");
  while (verb.length) {
    if (verb[0].checked) {
      subtract.push(verb[0].value)
    }
    else if (verb[2].checked) {
      add.push(verb[2].value)
    }
    i += 1;
    verb = document.getElementsByName("verb[" + i + "]");
  }

  if (add.length && subtract.length) {
    postAjax('/feedback/', { add: add, subtract: subtract}, function(data) {
      var response = JSON.parse(data);
      if (response.success == "true"){
        alert("Feedback successfully submitted");
        document.getElementById("hide_feedback").className = "d-none";
        document.getElementById("feedback").className = "d-none";
      }
      else {
        alert("Unable to submit feedback.")
      }
    });
  }
  else {
    alert("To submit the feedback you must like or dislike at least one sentence.")
  }

}
