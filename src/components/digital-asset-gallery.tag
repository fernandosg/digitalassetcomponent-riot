<digital-asset-gallery>
  <section>
    <aside>
      <ul>
        <li each="{nav in opts.navs_links}">
          <span onclick="{this.clickNav}" data-navid={nav.id} data-url="{nav.url}">{nav.label}</span>
        </li>
      </ul>
    </aside>
    <div>
      <div each="{item in opts.gallery}">
        <div>
          <img src="{item.image}" show={item.image !== ""}/>
          <div class="element_without_image" show={item.image == null || item.image == undefined || item.image===""}>
            <span href="javascript:void(0)" class="glyphicon glyphicon-folder-open folder-icon"></span>
          </div>
          {item.name}
        </div>
      </div>
    </div>
  </section>
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
      this.loadGallery(event.target.dataset);
    }

  </script>
</digital-asset-gallery>
