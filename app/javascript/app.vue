<template>
  <div id="app" class="center">
    <h1>People</h1>
      <vuetable ref="vuetable"
        api-url="http://localhost:3000/people/collection"
        :fields="fields"
        :css="css"
        pagination-path=""
        :per-page="10"
        @vuetable:pagination-data="onPaginationData"
      >
        <template slot="actions" scope="props">
          <div class="custom-actions" style="text-align: center">
            <button class="btn btn-default btn-sm"
              @click="onAction('view-item', props.rowData)">
              <span class="glyphicon glyphicon-zoom-in"></span>
            </button>
          </div>
        </template>
      </vuetable>
    <div>
      <vuetable-pagination-info ref="paginationInfo"
        :css="css.pagination"
        info-class="pull-left"
      ></vuetable-pagination-info>
      <vuetable-pagination ref="pagination"
        :css="css.pagination"
        @vuetable-pagination:change-page="onChangePage"
      ></vuetable-pagination>
    </div>
    </br>
    <!-- use the modal component, pass in the prop -->
    <modal v-if="showModal" @close="showModal = false" :text="this.details"></modal>
  </div>
</template>

<script>
import Vuetable from 'vuetable-2/src/components/Vuetable'
import VuetablePagination from 'vuetable-2/src/components/VuetablePagination'
import VuetablePaginationInfo from 'vuetable-2/src/components/VuetablePaginationInfo'
import BootstrapStyle from './bootstrap-css.js'
import Modal from './modal'


export default {
  components:{
    Vuetable,
    VuetablePagination,
    VuetablePaginationInfo,
    Modal
  },
  data: function () {
    return {
      css: BootstrapStyle,
      fields: ['name','__slot:actions'],
      details: '',
      showModal: false
    }
  },
  methods: {
   onPaginationData (paginationData) {
     this.$refs.pagination.setPaginationData(paginationData)
     this.$refs.paginationInfo.setPaginationData(paginationData)
   },
   onChangePage (page) {
     this.$refs.vuetable.changePage(page)
   },
   onAction(_action, item) {
     this.details = 'Loading...'
     this.showModal = true
     this.$http.get(`http://localhost:3000/people/${item.id}`).then(response => {
        this.details = response.body.greeting
      }, response => {
        console.log(response)
      });
   }
 }
}
</script>

<style>
  .pagination {
    margin-top: 0;
  }
  .btn.btn-border {
    border: 1px solid;
    margin-right: 2px;
  }
  .vuetable-pagination-info {
    margin-top: 8px !important;
  }
  span.sort-icon {
    float: right;
    color: #ff9100;
  }
  .center {
    margin: auto;
    width: 50%;
    padding: 50px;
  }
</style>
