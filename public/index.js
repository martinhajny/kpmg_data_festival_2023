$( document ).ready(function() {
    $('.socket').hide();
});


// Trigger generate DB endpoint on button click
$(document).on('click','.manageButton', function() {
    sendAjaxGenerateDB();
});

// Trigger query DB endpoint on button click
$(document).on('click','.searchButton', function() {
    sendAjaxQueryDB();
});


// Trigger query DB endpoint on enter key pressure
$('.searchTerm').on('keyup', function (e) {
    if (e.key === 'Enter' || e.keyCode === 13) {
        sendAjaxQueryDB();
    }
});


function sendAjaxGenerateDB() {
    $('.socket').show();
    $('.wrap-response h3').html("")
    $('.wrap-response p').html("")
    $.ajax({
        method: "POST",
        url: "/api/generate_database",
    })
    .done(function( msg ) {
        console.log(msg)
        $('.socket').hide();
        $('.wrap-response h3').html("Výsledek operace:")
        $('.wrap-response p').html(msg)
    });
}


function sendAjaxQueryDB() {
    $('.socket').show();
    $('.wrap-response h3').html("")
    $('.wrap-response p').html("")
    $('.wrap-response h3').eq(1).html("")
    $('.wrap-response p').eq(1).html("")
    $.ajax({
        method: "POST",
        url: "/api/query_database",
        data: { question: $('.searchTerm').val() }
    })
    .done(function( data ) {
        console.log(data)

        $('.socket').hide();
        $('.wrap-response h3').html("Odpověď z databáze:")
        $('.wrap-response p').html(data.answer)
        $('.wrap-response h3').eq(1).html("SQL dotaz:")
        $('.wrap-response p').eq(1).html(data.query)
    });
}