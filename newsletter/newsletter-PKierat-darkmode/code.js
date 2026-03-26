app_shop.run(function() {
  $('#menu_newsletter form').on('submit',function(){
      app_shop.formControl.validate($('#mailing_policy'));
      return app_shop.formControl.checkForm($(this));
  });

  $('#menu_newsletter').find('input').on('input', function(){
      clearTimeout(app_shop.formControl.timeHandle);
      obj = $(this);
      app_shop.formControl.timeHandle = setTimeout(function(){
          app_shop.formControl.validate(obj);
      }, 500);
  });

  $('#menu_newsletter button.add_newsletter').on('click', function(){
      app_shop.formControl.validate($('#mailing_policy'));
      return app_shop.formControl.checkForm($(this).parents('form'));
  });
}, 'all' , '#menu_newsletter');
