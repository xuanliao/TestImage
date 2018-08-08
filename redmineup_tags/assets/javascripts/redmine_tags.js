var tagsOldToggleFilter = window.toggleFilter;

window.toggleFilter = function (field) {
    tagsOldToggleFilter(field);
    return transform_tags_to_select2(field);
};

function transform_tags_to_select2(field) {
    initialized_select2 = $('#tr_' + field + ' .values .select2');
    if (field == 'issue_tags' && initialized_select2.size() == 0) {
        $('#tr_' + field + ' .toggle-multiselect').hide();
        $('#tr_' + field + ' .values .value').attr('multiple', 'multiple');
        $('#tr_' + field + ' .values .value').select2({
            ajax: {
                url: tagAutocompletePath,
                dataType: 'json',
                delay: 250,
                data: function (params) {
                    return {q: params.term};
                },
                processResults: function (data, params) {
                    return {results: data};
                },
                cache: true
            },
            placeholder: ' '
        });
    }
};


$(function () {
    $('body').on('click', '.most_used_tags .most_used_tag', function (e) {
        var $tagsSelect = $('select#issue_tag_list');
        var tag = e.target.innerText;
        if ($tagsSelect.find("option[value='" + tag + "']").length === 0) {
            var newOption = new Option(tag, tag, true, true);
            $tagsSelect.append(newOption).trigger("change");
        }

        mostUsedTags = $.grep(mostUsedTags, function(t) { return t != tag; });
        var tagsHtml = mostUsedTags.map(function(tag) {
            return '<span class="most_used_tag">' + tag + '</span>';
        }).join(', ');

        var $mostUsedTagsContainer = $(e.target).parent('.most_used_tags');
        $mostUsedTagsContainer.empty();
        $mostUsedTagsContainer.append(tagsHtml);
    });
});
