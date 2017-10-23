// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(function($) {

    var updateSingleRole = function (updatePath, roleId, rightId, accessLevel, successCallback) {
        var data = {
            right_id: rightId,
            access_level: accessLevel
        };

        $.ajax({
            url: updatePath,
            type: "PATCH",
            dataType: "script",
            data: data,
            success: function (returnData) {
                successCallback && successCallback();
            },
            error: function (e) {
                alert(e.responseText);
            }
        });
    };


    $(document).on('click', '.role-matrix-cell', function(e){
        var cell = $(this);

        var updatePath = cell.data('update-path');
        var rightId = cell.data('right-id');
        var roleId = cell.data('role-id');
        var currentAccessLevel = parseInt(cell.data('access-level'));
        var newAccessLevel = currentAccessLevel == RIGHT_YES ? RIGHT_NO : RIGHT_YES;

        updateSingleRole(updatePath, roleId, rightId, newAccessLevel, function(){
            var td = cell.parent();
            cell.data('access-level', newAccessLevel);

            if (newAccessLevel == RIGHT_YES){
                cell.addClass('glyphicon-ok');
                cell.removeClass('glyphicon-minus');
                td.addClass('success');
            } else {
                cell.removeClass('glyphicon-ok');
                cell.addClass('glyphicon-minus');
                td.removeClass('success');
            }

        });
    });



    $(document).on('change', '.roles-rights-select', function(e){
        var selectInput = $(this);
        var newAccessLevel = parseInt(selectInput.val());
        var row = selectInput.closest('tr');

        if (newAccessLevel == RIGHT_YES){
            row.addClass('success');
        } else {
            row.removeClass('success');
        }
    });



    $(document).on('change', '.users-rights-select', function(e){
        var selectInput = $(this);
        var row = selectInput.closest('tr');

        var rightNameCell = row.children('.right-name-cell');
        var userLevelCell = selectInput.parent();
        var roleLevelCell = row.children('[data-roles-rights-access-level]');

        var accessLevelOfUser = parseInt(selectInput.val());
        var accessLevelOfRole = parseInt(roleLevelCell.data('roles-rights-access-level'));


        var access;
        switch (accessLevelOfUser) {
            case RIGHT_NO:
                access = false;
                userLevelCell.removeClass('success');
                break;
            case RIGHT_YES:
                access = true;
                userLevelCell.addClass('success');
                break;
            case RIGHT_ACCESS_OF_ROLE:
                userLevelCell.removeClass('success');
                switch (accessLevelOfRole) {
                    case RIGHT_NO:
                        access = false;
                        break;
                    case RIGHT_YES:
                        access = true;
                        break;
                }
                break;
        }

        access == true ? rightNameCell.addClass('success') : rightNameCell.removeClass('success');

    });

});





