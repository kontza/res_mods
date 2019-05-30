/**
 * Normal carousel cells settings
 * Настройки ячеек карусели обычного размера
 */
{
  // Definitions
  // Шаблоны
  "def": {
    // Text fields shadow.
    // Тень текстовых полей.
    "textFieldShadow": { "enabled": true, "color": "0x000000", "alpha": 80, "blur": 2, "strength": 2, "distance": 0, "angle": 0 }
  },
  "normal": {
    // Cell width
    // Ширина ячейки
    "width": 160,
    // Cell height
    // Высота ячейки
    "height": 100,
    // Spacing between carousel cells.
    // Отступ между ячейками карусели.
    "gap": 10,
    // Standard cell elements.
    // Стандартные элементы ячеек.
    "fields": {
      // "enabled"  - the visibility of the element / видимость элемента
      // "dx"       - horizontal shift              / смещение по горизонтали
      // "dy"       - vertical shift                / смещение по вертикали
      // "alpha"    - transparency                  / прозрачность
      // "scale"    - scale                         / масштаб
      //
      // Nation flag.
      // Флаг нации.
      "flag": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },

      // Vehicle icon.
      // Иконка танка.
      "tankIcon": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Vehicle class icon.
      // Иконка типа техники.
      "tankType": { "enabled": true, "dx": 124, "dy": 60, "alpha": 100, "scale": 1 },
      // Vehicle level.
      // Уровень техники
      "level":    { "enabled": true, "dx": 124, "dy": 61, "alpha": 100, "scale": 1 },

      // Double XP icon
      // Иконка не сбитого опыта за первую победу в день.
      "xp":       { "enabled": true, "dx": 3, "dy": 0, "alpha": 100, "scale": 1 },
      // Vehicle name.
      // Название танка.
      "tankName": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1, "textFormat": {}, "shadow": {} },
      // Vehicle rent info text.
      // Инфо текст аренды танка.
      "rentInfo": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1, "textFormat": {}, "shadow": {} },
      // Info text (Crew incomplete, Repairs required)
      // Инфо текст (Неполный экипаж, Требуется ремонт).
      "info":     { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1, "textFormat": {}, "shadow": {} },
      // Info image
      // Инфо иконка
      "infoImg":  { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      // Info text for "Buy vehicle" and "Buy slot" slots.
      // Инфо текст для слотов "Купить машину" и "Купить слот".
      "infoBuy":  { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1, "textFormat": {}, "shadow": {} },
      // Clan lock timer
      // Таймер блокировки танка
      "clanLock": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100 },
      // Price
      // Цена
      "price":    { "enabled": false, "dx": 0, "dy": 0, "alpha": 100 },
      // Action price
      // Акционная цена
      "actionPrice": { "enabled": false, "dx": 0, "dy": 0, "alpha": 100 },
      // Favorite vehicle mark
      // Маркер основной техники
      "favorite": { "enabled": false, "dx": 0, "dy": 0, "alpha": 100 },
      // Stats field that appears on the mouse hover
      // Поле статистики, отображаемое при наведении мыши
      "stats": { "enabled": false, "dx": 0, "dy": 0, "alpha": 100, "textFormat": {}, "shadow": {} }
    },
    // Extra cell fields (extended format supported, see extra-field.txt).
    // Дополнительные поля ячеек (поддерживается расширенный формат, см. extra-field.txt).
    "extraFields": [

      // **** background
      // Подложка слота
      { "x": 1, "y": 1, "layer": "substrate", "width": 160, "height": 100, "bgColor": "0x0A0A0A" },

      // **** Sign of mastery
      // Знак мастерства
      {
        "enabled": true,
        "x": 1, "y": 77, "width": 23, "height": 23,
        "src": "img://gui/maps/icons/library/proficiency/class_icons_{{v.mastery}}.png"
      },

      // **** Battles count
      // Количество боёв
      {
        "enabled": true,
        "x": 3, "y": 3, "width": 12, "height": 12,
        "src": "cfg://default/img/icon-battles.png"
      },
      {
        "enabled": true,
        "x": 18, "y": 0,
        "format": "<b><font face='$FieldFont' size='12' color='#CFCFCF'>{{v.battles}}</font></b>",
        "shadow": ${ "def.textFieldShadow" }
      },

      // **** Winrate
      // Процент побед
      {
        "enabled": false,
        "x": 3, "y": 17, "width": 12, "height": 12,
        "src": "cfg://default/img/icon-wins.png"
      },
      {
        "enabled": false,
        "x": 18, "y": 14,
        "format": "<b><font face='$FieldFont' size='12' color='{{v.c_winrate|#CFCFCF}}'>{{v.winrate%5.2f~%|0}}</font></b>",
        "shadow": ${ "def.textFieldShadow" }
      },

      // **** MOE progression
      {
        "enabled": false,
        "x": 18, "y": 28,
        "format": "<b><font face='$FieldFont' size='12' color='{{v.c_damageRating|#CFCFCF}}'>{{v.damageRating%5.2f~%|0}}</font></b>",
        "shadow": ${ "def.textFieldShadow" }
      },

      // **** Average damage
      // Средний урон
      {
        "enabled": false,
        "x": 3, "y": 45, "width": 12, "height": 12,
        "src": "cfg://default/img/icon-damage.png"
      },
      {
        "enabled": false,
        "x": 18, "y": 42,
        "format": "<b><font face='$FieldFont' size='12' color='{{v.c_xtdb|#CFCFCF}}'>{{v.tdb%d|0}}</font></b>",
        "shadow": ${ "def.textFieldShadow" }
      }

    ]
  }
}
