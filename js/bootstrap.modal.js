var jQueryDialogToBootstrap = {

  _interpretedDialogs : "*",

  init : function() {
    this._setEvent();
  },

  _setEvent : function() {
    var objectInstance = this;

    jQuery(this._interpretedDialogs).on( "dialogopen", function( event, ui ) {
      objectInstance._onDialogOpen((jQuery(this).hasClass("ui-dialog-content") ? jQuery(this) : jQuery(".ui-dialog")), event, ui);
    });
  },

  _onDialogOpen : function(dialogContentObject, event, ui) {
    var dialogBase;

    if(dialogContentObject.hasClass("ui-dialog-content"))
       dialogBase = dialogContentObject.parent();
    else
       dialogBase = dialogContentObject;

    if(dialogBase.length > 0) {
      
          dialogBase.addClass("modal-content");
          dialogBase.removeClass("ui-dialog ui-widget ui-widget-content ui-corner-all");

      var dialogTitleContainer   = dialogBase.find("> .ui-dialog-titlebar"),
          dialogContentContainer = dialogBase.find("> .ui-dialog-content"),
          dialogFooterContainer  = dialogBase.find("> .ui-dialog-buttonpane");


      // Transform the title container into Boostrap Style .
      dialogTitleContainer.addClass("modal-header")
                          .removeClass("ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix");

      // Transform the "span" Title into a modal style title.
      dialogTitleContainer.find(".ui-dialog-title")
                          .removeClass("ui-dialog-title")
                          .addClass("modal-title");

      // Transform the span to a h4 in the title container
      dialogTitleContainer.find(".modal-title")
                          .replaceWith('<h4 class="modal-title">' + dialogTitleContainer.find(".modal-title").html() + '</h4>');
      dialogTitleContainer.find(".modal-title")
                          .css("display", "inline-block");

      // Transform the "Close" Button on the top-right into a boostrap style close.
      dialogTitleContainer.find(".ui-dialog-titlebar-close")
                          .removeClass("ui-dialog-titlebar-close")
                          .addClass("close")
                          .html("×");

      // Set the content of the modal properly, bootstrap style.
      dialogContentContainer.addClass("modal-body");
      dialogContentContainer.removeClass("ui-dialog-content ui-widget-content");

      // Set the footer of the modal properly, bootstrap style.
      dialogFooterContainer.addClass("modal-footer");
      dialogFooterContainer.removeClass("ui-dialog-buttonpane ui-widget-content ui-helper-clearfix");
      // Transform all the buttons if they exist into bootstrap 3 style ones.
      dialogFooterContainer.find("button")
                           .removeClass("ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only ui-button-text-icon-primary")
                           .addClass("btn btn-primary")
                           .css("margin-bottom", 0); // To work properly with jQuery UI and be lined good.
    }
  }

};

jQuery(function() {
  jQueryDialogToBootstrap.init();
});