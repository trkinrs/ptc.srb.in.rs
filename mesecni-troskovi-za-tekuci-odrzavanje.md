---
layout: page
---

<dl>
  <dt>Rok uplate:</dt>
  <dd>Do 10-tog u mesecu</dd>
  <dt>Primalac:</dt>
  <dd><code>{{ site.primalac }}</code></dd>
  <dt>Racun:</dt>
  <dd><code>{{ site.broj_racuna }}</code></dd>
  <dt>Svrha uplate:</dt>
  <dd><code>{{ site.svrha_uplate }}</code></dd>
</dl>

Tabelu svih lokala i iznosa za uplatu mozete naci na [ovom linku](https://docs.google.com/spreadsheets/d/1F7izVPTK6DkA3FTw5m5lxNT_6Bj4833d/edit?usp=sharing&ouid=115381639889859115660&rtpof=true&sd=true)
<ul>
{% for lokal in site.data.mesecni_troskovi %}
  {% assign srednja_vrednost = lokal.srednja_vrednost | format: "%.2f" | replace: ".", "," %}
  <li>
    <strong>{{ lokal.br_lokala}} {{ lokal.vlasnik }}</strong>
    {{ lokal.povrsina }}m2
    <code>{{ srednja_vrednost }} din</code>
    <label for="{{ lokal.br_lokala }}">IPS</label>
    <input type="checkbox" id="{{ lokal.br_lokala}}" data-toggle-next-element>
    <div>
      Uplatilac: <strong>{{ lokal.vlasnik }}</strong><br>
      Iznos: <strong>{{ srednja_vrednost | replace: ".", "," }}</strong><br>
      Model <strong>00</strong>, Poziv na broj: <strong>{{ lokal.br_lokala }}</strong><br>
      <img src="/images/ips-lokal-{{ lokal.br_lokala }}.png">
    </div>
  </li>
{% endfor %}
</ul>
