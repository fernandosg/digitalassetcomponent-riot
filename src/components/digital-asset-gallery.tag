<digital-asset-gallery>
  <section>
    <aside>
      <ul>
        <li each="{nav in opts.navs_links}">
          <span>{nav.label}</span>
        </li>
      </ul>
    </aside>
    <div>
      <div each="{item in gallery}">
        <span>
          {item.name}
        </span>
      </div>
    </div>
  </section>
</digital-asset-gallery>
