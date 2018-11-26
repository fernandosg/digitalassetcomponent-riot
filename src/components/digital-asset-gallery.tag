<digital-asset-gallery>
  <section id="digital-asset-gallery" class="modal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <header class="modal-header">
          <h4 class="modal-title">File selector</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </header>
        <section class="row">
          <aside id="folder_list" class="col-md-4">
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
            <div class="text-center asset-area" each="{item in opts.gallery}" data-itemid={item.id} data-image="{item.image}">
              <div class="digital-assets-image" onclick="{this.selectGalleryItem}">
                <img class="img-thumbnail attachment digital_asset_attachment" src="{item.image}" show={item.image !== ""} style="width:100%;"/>
                <span href="javascript:void(0)" show={item.image == null || item.image == undefined || item.image===""} class="glyphicon glyphicon-file file-icon"></span>
              </div>
              <div>{item.name}</div>
            </div>
          </div>
        </section>
      </div>
    </div>
  </section>
  <script>

    this.on('mount', function() {
      if(this.opts.visible)
        $("#digital-asset-gallery").modal('show');
    })

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
      this.loadGallery(event.target.dataset);
    }

    this.selectGalleryItem = (event) => {
      var parent_container = event.target.parentNode.parentNode;
      var elements = document.getElementsByClassName(parent_container.className);
      for(var i=0, length=elements.length;i<length;i++){
        $(elements[i]).removeClass("active");
      }
      $(parent_container).addClass("active");
      if(this.opts.callbackSellectGalleryItem && parent_container.dataset.itemid){
        this.opts.callbackSellectGalleryItem(parent_container.dataset.itemid);
      }
    }

  </script>
</digital-asset-gallery>
