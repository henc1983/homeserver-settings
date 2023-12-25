(function($){
    $(document).on('click', '.navbar-toggler, .sidebar-backdrop', function(){
        var sidebar = $('#sidebar');
        if(!sidebar.hasClass('active')){
            $('body').css({'overflow':'hidden'}).append($('<div></div>').addClass('backdrop sidebar-backdrop'));
            $('.sidebar-backdrop').animate({'opacity': 1}, 300);
            sidebar.addClass('active');
            return false;
        }
        sidebar.removeClass('active');
        $('.sidebar-backdrop').animate({'opacity': 0}, 300, function(){
            $('body').removeAttr('style');
            $(this).remove();
        });

    });

    $(document).on('click', '#sidebar a.nav-link', function(e){
        e.preventDefault();
        $('.navbar-toggler').trigger('click');
        setTimeout(()=>{
            window.location.href = e.currentTarget.href
        }, 300);
    });
})(jQuery)