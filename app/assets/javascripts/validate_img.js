$("#product_image").bind("change", function() {
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > Settings.products.size_image_upload) {
    alert(I18n.t("admin.products.alert_image_size"));
  }
});
