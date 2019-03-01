$(document).on('turbolinks:load', function() {
    // 画像のプレビュー
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

    // 自動保存機能
    function ajaxAutoSave() {
        console.log('autosave');
    }
    // 5秒後に自動保存
    var timer_id = setTimeout(ajaxAutoSave, 5000);

    // 記事を編集するごとにsetTimeoutをリセット
    $('.form-group').on('change',function(e) {
        console.log(e);
        clearTimeout(timer_id);
        timer_id = setTimeout(ajaxAutoSave, 5000);
    });

    //  CKEditor インスタンスの準備完了をキャッチ
    CKEDITOR.on('instanceReady', function(e) {
        var editor = e.editor;

        editor.on('change', function() {
            clearTimeout(timer_id);
            timer_id = setTimeout(ajaxAutoSave, 5000);
        });
    });

});