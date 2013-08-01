(function() {
    var left = false,
        votted = false;

    $('.votes').mouseover(function(e) {
        var that = this;

        if ($(this).attr('class').search('votted') === -1) {
            $(this).addClass('votting');
            window.setTimeout(function() {
                if ($(that).attr('class').search('votting') !== -1) {
                    $(that).removeClass('votting')
                           .addClass('votted')
                           .attr('title', '投票成功')
                           .click(function(e) {
                               e.preventDefault();
                               $(this).removeClass('votted')
                                      .attr('title', '不要移开，正在投票...')
                                      .html($(this).attr('data-votes'));
                           });
                    $(that).html('<i class="icon-thumbs-up"></i>');
                }
            }, 2500);
        }
    }).mouseout(function(e) {
        if ($(this).attr('class').search('votting') !== -1) {
            $(this).removeClass('votting');
        }
    });
})();
