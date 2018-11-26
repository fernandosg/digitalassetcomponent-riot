<digital-asset-gallery>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <header class="modal-header">
        <h4 class="modal-title">File selector</h4>
        <button type="button" class="close" data-dismiss="modal">×</button>
      </header>
      <section class="row">
        <aside class="col-md-4">
          <div class="tree-menu-container">
            <ul class="tree-menu">
              <li class="folder-link-container" each="{nav in opts.navs_links}">
                <a class="toggle_list_menu glyphicon glyphicon-chevron-right"></a>
                <span class="link" onclick="{this.clickNav}" data-navid={nav.id} data-url="{nav.url}" style="cursor:pointer;">{nav.label}</span>
              </li>
            </ul>
          </div>
        </aside>
        <div id="folder_assets" class="col-md-8 folder-assets-block-section">
          <div class="text-center asset-area" each="{item in opts.gallery}">
            <div class="digital-assets-image">
              <img class="img-thumbnail attachment digital_asset_attachment" src="{item.image}" show={item.image !== ""} style="width:100%;"/>
              <div class="element_without_image" show={item.image == null || item.image == undefined || item.image===""}>
                <span href="javascript:void(0)" class="glyphicon glyphicon-folder-open folder-icon"></span>
              </div>
            </div>
            <div>{item.name}</div>
          </div>
        </div>
      </section>
    </div>
  </div>
  <script>
    this.loadGallery = (dataset) => {
      var self = this;
      $.ajax({
        method: "GET",
        url: "/server/"+dataset.url,
        data: {"id": dataset.navid},
        dataType:"JSON"
      }).done(function(response){
        self.opts.gallery = response.gallery;
        self.update();
      }).fail(function(response){
      })
    }

    this.clickNav = (event) => {
      console.log("cliqueando");
      this.loadGallery(event.target.dataset);
    }

  </script>
</digital-asset-gallery>
