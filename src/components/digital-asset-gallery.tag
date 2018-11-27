<digital-asset-gallery>
  <section id="digital-asset-gallery" class="modal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <header class="modal-header">
          <h4 class="modal-title">File selector</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </header>
        <div id="upload_asset_modal_body" class="modal-body">
          <section class="row">
            <aside id="folder_list" class="col-md-4">
              <div class="tree-menu-container">
                <ul class="tree-menu">
                  <li class="folder-link-container" each="{nav in opts.navs_links}">
                    <a class="toggle_list_menu glyphicon glyphicon-chevron-right"></a>
                    <span class="link" onclick="{this.clickNav}" data-navid={nav.id} data-url="{nav.url}" style="cursor:pointer;">{nav.name}</span>
                  </li>
                </ul>
              </div>
            </aside>
            <div id="folder_assets" class="col-md-8 folder-assets-block-section">
              <div class="text-center asset-area" each="{item in opts.gallery}" data-itemid={item.id}  data-itemname={item.attachment_file_name} data-image="{item.attachment_file_name}">
                <div class="digital-assets-image" onclick="{this.selectGalleryItem}">
                  <img class="img-thumbnail attachment digital_asset_attachment" src="{item.image_url}" show={item.attachment_file_name !== ""} style="width:100%;"/>
                  <span href="javascript:void(0)" show={item.attachment_file_name == null || item.attachment_file_name == undefined || item.attachment_file_name===""} class="glyphicon glyphicon-file file-icon"></span>
                </div>
                <div>{item.label}</div>
              </div>
            </div>
          </section>
        </div>
      </div>
    </div>
  </section>
  <script>
    var page = 0;
    var self;
    var tag;
    var scrolling = true;
    this.on('mount', function() {
      self = this;
      tag = document.getElementById("digital-asset-gallery");
      if(this.opts.visible)
        $("#digital-asset-gallery").modal('show');
      if(!this.opts.root_path && this.opts.root_path!==""){
        this.opts.root_path = "/server/";
      }
      if(this.opts.tag_id){
        tag.setAttribute("id", this.opts.tag_id);
      }
      this.attachNavigating();
    })

    var endpoint_url;

    this.attachNavigating = () =>{
      paginating = this.opts.paginating;
      if(paginating){
        page = 1;
        $(tag).find("#folder_assets").on('scroll', function() {
          if($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight && paginating) {
            if(scrolling){
              scrolling = false;
              page++;
              self.getNextPageUrl();
            }
          }
        })
      }
    }

    this.getUrlLoadGallery = (dataset) =>{
      if(this.opts.endpoint_open){
        var url = this.opts.endpoint_open.replace(this.opts.param_replace_endpoint, dataset[this.opts.param_endpoint]);
        endpoint_url = url;
        return url;
      }
      return "/server/services.php";
    }

    this.getNextPageUrl = () =>{
      $.ajax({
        method: "GET",
        url: endpoint_url,
        data: {"id": actual_navid, "page":page},
        dataType:"JSON"
      }).done(function(response){
        if(response.gallery && response.gallery.length > 0){
          self.opts.gallery = self.opts.gallery.concat(response.gallery);
          self.update();
          scrolling = true;
          setTimeout(function(){ scrolling = true; }, 3000);
        }else{
          paginating = false;
        }
      }).fail(function(response){
        console.log("fallo");
        console.log(response);
      })
    }

    this.loadGallery = (dataset) => {
      actual_navid = dataset.navid;
      page = 1;
      scrolling = true;
      this.attachNavigating();
      $.ajax({
        method: "GET",
        url: self.getUrlLoadGallery(dataset),
        data: {"id": dataset.navid},
        dataType:"JSON"
      }).done(function(response){
        console.log("cargando");
        self.opts.gallery = response.gallery;
        self.update();
      }).fail(function(response){
        console.log("fallo");
        console.log(response);
      })
    }

    this.nextPage = (dataset) => {
      actual_navid = dataset.navid;
      $.ajax({
        method: "GET",
        url: self.getUrlLoadGallery(dataset),
        data: {"id": dataset.navid},
        dataType:"JSON"
      }).done(function(response){
        console.log("cargando");
        self.opts.gallery = response.gallery;
        self.update();
      }).fail(function(response){
        console.log("fallo");
        console.log(response);
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
        this.opts.callbackSellectGalleryItem(parent_container.dataset.itemid, parent_container.dataset.itemname);
      }
    }

  </script>
</digital-asset-gallery>
