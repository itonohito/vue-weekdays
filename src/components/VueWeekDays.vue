<template>
  <div>
    <ul :class="list_class">
      <li
        :class="item_class"
        v-for="(day, idx) in days"
        :data-day="idx"
        :key="day"
        ref="day_elems"
        @click="on_item_selected(idx)"
      >{{ day }}</li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "VueWeekdays",
  props: ['daynames', 'multiple', 'value'],
  data: function () {
    return {
      selected_indexes: [...this.value] || [],
      days: [...this.daynames] || ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
      list_class: 'weekdays-list',
      item_class: 'weekdays-day',
      item_selected_class: 'weekday-selected',
      single_select: this.multiple === undefined
    }
  },

  mounted: function () {
    this.$refs.day_elems.forEach((elem, i) => {
      if (this.selected_indexes.includes(i)) {
        elem.classList.add(this.item_selected_class);
      }
    });
  },
  methods: {
    on_item_selected(idx) {
      if (this.single_select)
        this.deselect_all();

      this.toggle_selection(idx);
      this.$emit('input', this.selected_indexes);
    },

    deselect_all() {
      this.selected_indexes = [];
      this.$refs.day_elems.forEach(elem => {
        elem.classList.remove(this.item_selected_class);
      });
    },

    toggle_selection(idx) {
      let elem = this.$refs.day_elems[idx];

      if (this.selected_indexes.includes(idx)) {
        this.selected_indexes = this.selected_indexes.filter(function (v) {
          return v != idx
        });
        elem.classList.remove(this.item_selected_class);
      }
      else {
        this.selected_indexes.push(idx);
        elem.classList.add(this.item_selected_class);
      }
    }
  }
}
</script>

<style scoped>
.weekdays-list {
  display: flex;
  padding-left: 0;
  list-style: none;
  border-radius: 0.5rem;
}

.weekdays-list .weekdays-day {
  position: relative;
  display: block;
  padding: 0.3rem 0.4rem;
  margin-left: -1px;
  line-height: 1;
  font-size: 14px;
  font-weight: bold;
  color: dimgray;
  background-color: #fff;
  border: 1px solid darkgray;
  cursor: pointer;
}

.weekdays-day:hover {
  background-color: palegoldenrod;
}

.weekdays-day.weekday-selected {
  color: palegoldenrod;
  background-color: #6c757d;
  font-weight: bold;
  border: 1px solid white;
  border-top: 1px solid darkgray;
  border-bottom: 1px solid darkgray;
}

.weekdays-list :first-child {
  border-left: 1px solid darkgray;
}

.weekdays-list :last-child {
  border-right: 1px solid darkgray;
}
</style>
