$(document).on('turbolinks:load', function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#eyecatch_img_prev').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $(".post-img").change(function() {
        $('#eyecatch_img_prev').removeClass('hidden');
        $('.eyecatch_present_img').remove();
        readURL(this);
    });
});