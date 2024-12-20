---
layout: center
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


Iznos za uplatu je srednja vrednost od iznosa: 25din/m2 i 1.000din po lokalu.
<br>
Tabelu svih lokala i iznosa za uplatu mozete naci na [ovom linku](https://docs.google.com/spreadsheets/d/1F7izVPTK6DkA3FTw5m5lxNT_6Bj4833d/edit?usp=sharing&ouid=115381639889859115660&rtpof=true&sd=true)

<div>
  <em>
    <table>
      <thead>
        <tr>
          <th>Broj lokala</th>
          <th>Naziv/povrsina</th>
          <th>Iznos za mesecnu uplatu</th>
          <th>IPS</th>
          <th>Datum poslednje uplate</th>
          <th>Ukupno uplaceno</th>
          <th>Dug</th>
        </tr>
      </thead>
      <tbody>
        {% for office in site.data.monthly_costs %}
          {% assign total_amount = 0 %}
          {% assign last_date = "" %}
          <tr>
            <td>{{ office.office_id}}</td>
            <td>
              {{ office.name }}<br>
              {{ office.area }}m2
            </td>
            <td>
              <code>{{ office.average_cost | format_price}}</code>
            </td>
            <td>
              <label for="ips-{{ office.office_id }}" class="blue">Plati preko IPS</label>
              <input type="checkbox" id="ips-{{ office.office_id}}" data-toggle-next-element>
              <div class="modal">
                Uplatilac: <strong>{{ office.name }}</strong><br>
                Iznos: <strong>{{ office.average_cost | format_price | replace: ".", "," }}</strong><br>
                Model <strong>00</strong>,<br>
                Poziv na broj: <strong>{{ office.office_id }}</strong><br>
                <img src="/images/ips-lokal-{{ office.office_id }}.png">
              </div>
            </td>
            {% assign payments = site.data.payments | where:"office_id",office.office_id | sort: "date" %}
            {% for payment in payments %}
              {% assign total_amount = total_amount | plus: payment.amount %}
              {% assign last_date = payment.date %}
            {% endfor %}
            <td>
              {{ last_date }}
            </td>
            <td>
              <label for="payments-{{ office.office_id }}" class="blue">
              {{ total_amount | format_price }}
              </label>
              <input type="checkbox" id="payments-{{ office.office_id}}" data-toggle-next-element>
              <ol class="hidden modal">
                {% for payment in payments %}
                <li>{{ payment.date }}. {{ payment.amount }}</li>
                {% endfor %}
              </ol>
            </td>
            <td>
              {% assign current_month = "now" | date: "%m" | plus: 0 %} <!-- Convert string to number -->
              {% assign result = average_cost | times: current_month %}
              <b>{{ result | format_price }}</b>
            </td>
          </tr>
        {% endfor %}
      </tbody>
    </table>
  </em>
</div>
