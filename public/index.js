$( document ).ready(function() {
    $('.socket').hide();
});

$('.searchTerm').on('keyup', function (e) {
    if (e.key === 'Enter' || e.keyCode === 13) {
        sendAjax();
    }
});

function sendAjax() {
    $('.socket').show();
    $('.wrap-response h3').html("")
    $('.wrap-response p').html("")
    $.ajax({
        method: "POST",
        url: "/api",
        data: { question: $('.searchTerm').val() }
    })
    .done(function( msg ) {
        console.log(msg)
        $('.socket').hide();
        $('.wrap-response h3').html("Odpověď z databáze:")
        $('.wrap-response p').html(msg)
    });
}