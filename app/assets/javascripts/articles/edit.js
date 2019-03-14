CKEDITOR.config.height=500;
$(document).on('turbolinks:load', function() {
    // 画像のプレビュー
    function readURL(input) {
        if (input.files && input.files[0]) {
            let reader = new FileReader();

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
    function ajaxAutoSave(form_id) {
        if (typeof form_id == 'undefined') {
            Rails.fire($('#ajax-form-tmp')[0], "submit");
            $('.saving').removeClass('hidden');
        } else {
            Rails.fire($(form_id)[0], "submit");
        }
    }

    // 5秒後に自動保存(ページ遷移時に保存されないように即停止)
    var timer_id = setTimeout(ajaxAutoSave, 5000);
    clearTimeout(timer_id);

    // 記事を編集するごとにsetTimeoutをリセット
    $('#ajax-form-tmp > .form-group').on('change',function() {
        clearTimeout(timer_id);
        timer_id = setTimeout(ajaxAutoSave, 5000);
    });

    $('#ajax-form-add-eyecatch > .form-group').on('change',function() {
       ajaxAutoSave('#ajax-form-add-eyecatch');
    });

    //  CKEditorにおける自動保存
    CKEDITOR.on('instanceReady', function(e) {
        let editor = e.editor;

        editor.on('change', function() {
            clearTimeout(timer_id);
            timer_id = setTimeout(ajaxAutoSave, 5000);
        });
    });

    $('.ajax-form').submit(function() {
        allSubmitDisabled(true);
    });

    $(document).on('ajax:success', "#ajax-form-tmp", function(e) {
        $('.saving').addClass('hidden');
        if (e.detail[0].result === "ok") {
            $('.saved').removeClass('hidden');
            $('.now-time').html(getNowTime());
            updateEdited($('#edited-title-or-text'));
        } else {
            $('.failed-save').removeClass('hidden');
            $('.now-time').html(getNowTime());
        }
        allSubmitDisabled(false);
    });

    function getNowTime() {
        let now = new Date();

        let month = now.getMonth() + 1;
        let day = now.getDate();
        let hour = now.getHours();
        let minutes = now.getMinutes();
        let seconds = now.getSeconds();
        return "(" + month + "/" + day + " " + hour + ":" + minutes + ":" + seconds + ")"
    }

    $(document).on('ajax:success', "#ajax-form-publish", function(e) {
        if ($('.eyecatch_present_img').attr('src') !== "#" || $('#eyecatch_img_prev').is()) {
            changeSubmitState('#delete-eyecatch-btn', false, "画像を削除する");
        }
        $(".edited").each(function() {
            $(this).addClass('hidden');
        });
        allSubmitDisabled(false);
    });

    $(document).on('ajax:success', "#ajax-form-add-eyecatch", function(e) {
        changeSubmitState('#delete-eyecatch-btn', false, "下書き画像を削除する");

        updateEdited($('#edited-eyecatch'));
        allSubmitDisabled(false);
    });

    $(document).on('ajax:success', "#ajax-form-remove-eyecatch", function(e) {
        let result = e.detail[0].result;
        var eyecatch_image_path = e.detail[0].eyecatch_image_path;
        if (result === "removed_tmp_eyecatch") {
            if (!eyecatch_image_path) {
                timer_id = setTimeout(removeBtnDisabled, 1000); //仕様上disabledにならない問題を回避
                $('.eyecatch_present_img, #eyecatch_img_prev').attr('src', '/no-image.png');
            } else {
                changeSubmitState('#delete-eyecatch-btn', false, "画像を削除する");
                $('.eyecatch_present_img, #eyecatch_img_prev').attr('src', eyecatch_image_path);
            }
        } else if (result === "removed_eyecatch") {
            timer_id = setTimeout(removeBtnDisabled, 1000); //仕様上disabledにならない問題を回避
            $('.eyecatch_present_img, #eyecatch_img_prev').attr('src', '/no-image.png');
        }

        var edited_elem = $('#edited-eyecatch');
        if (!edited_elem.hasClass('hidden')) {
            edited_elem.addClass('hidden');
        }
        allSubmitDisabled(false);
    });

    function changeSubmitState(id, state, value) {
        let elem = $(id);
        if (state != undefined) {
            elem.prop('disabled', state);
        }
        if (value != undefined) {
            elem.attr('value', value);
        }
    }

    function allSubmitDisabled(state) {
        $(".ajax-submit").each(function() {
            $(this).prop('disabled', state);
        });
    }

    function removeBtnDisabled() {
        let btn = $('#delete-eyecatch-btn');
        btn.prop('disabled', true);
        btn.attr('value', '画像を削除する');
    }
    
    function updateEdited(elem) {
        if (elem.hasClass('hidden')) {
            elem.removeClass('hidden');
        }
    }

    $(document).on('click', '.upload-file-btn', function() {
        $(".post-img").click();
    })

});