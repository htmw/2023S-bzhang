<template>
  <view class="tn-swipe-action-item-class tn-swipe-action-item">
    <view class="tn-swipe-action-item__right">
      <slot name="button">
        <view
          v-for="(item, index) in options"
          :key="index" 
          class="tn-swipe-action-item__right__button"
          :style="[{
            alignItems: item.style && item.style.borderRadius ? 'center' : 'stretch'
          }]"
          @tap="buttonClickHandler(item, index)"
        >
          <view
            class="tn-swipe-action-item__right__button__wrapper"
            :style="[{
              backgroundColor: item.style && item.style.backgroundColor ? item.style.backgroundColor : '#AAAAAA',
              borderRadius: item.style && item.style.borderRadius ? item.style.borderRadius : '0',
              padding: item.style && item.style.borderRadius ? '0' : '0 30rpx'
            }, item.style]"
          >
            <view
              v-if="item.icon"
              :class="[`tn-icon-${item.icon}`]"
              :style="[{
                color: item.style && item.style.color ? item.style.color : '#FFFFFF',
                fontSize: item.iconSize ? item.iconSize + 'rpx' : item.style && item.style.fontSize ? (item.style.fontsize * 1.2) + 'rpx' : '34rpx',
                marginRight: item.text ? '4rpx' : 0
              }]"
            ></view>
            <text
              v-if="item.text"
              class="tn-swipe-action-item__right__button__text tn-text-ellipsis"
              :style="[{
                color: item.style && item.style.color ? item.style.color : '#FFFFFF',
                fontSize: item.style && item.style.fontSize ? item.style.fontSize + 'rpx' : '32rpx',
                lineHeight: item.style && item.style.fontSize ? item.style.fontSize + 'rpx' : '32rpx'
              }]"
            >{{ item.text }}</text>
          </view>
        </view>
      </slot>
    </view>
    
    <view
      class="tn-swipe-action-item__content"
      :status="status"
      :size="size"
      :change:status="wxs.statusChange"
      :change:size="wxs.sizeChange"
      @touchstart="wxs.touchStart"
      @touchmove="wxs.touchMove"
      @touchend="wxs.touchEnd"
    >
      <slot></slot>
    </view>
  </view>
</template>

<!-- #ifdef APP-VUE || MP-WEIXIN || H5 || MP-QQ -->
<script src="./index.wxs" module="wxs" lang="wxs"></script>
<!-- #endif -->
<script>
  
  export default {
    name: 'tn-swipe-action-item',
    props: {
      // ????????????????????????
      show: {
        type: Boolean,
        default: false
      },
      // ?????????????????????v-for??????index????????????
      name: {
        type: [String, Number],
        default: ''
      },
      // ??????????????????
      options: {
        type: Array,
        default() {
          return []
        }
      },
      // ????????????
      disabled: {
        type: Boolean,
        default: false
      },
      // ????????????????????????swipe?????????
      autoClose: {
        type: Boolean,
        default: true
      },
      // ???????????????????????????????????????????????????
      threshold: {
        type: Number,
        default: 20
      },
      // ???????????????????????????ms
      duration: {
        type: Number,
        default: 300
      }
    },
    computed: {
      // ??????wxs???????????????????????????????????????????????????????????????????????????????????????
      itemData() {
        return [this.disabled, this.autoClose, this.threshold, this.options, this.duration]
      }
    },
    data() {
      return {
        // ??????????????????
        size: {},
        // ???????????????
        parentData: {
          autoClose: true
        },
        // ????????????
        status: 'close'
      }
    },
    watch: {
      itemData() {
        this.queryRect()
      }
    },
    created() {
      this.parent = false
      this.updateParentData()
      this.parent && this.parent.children.push(this)
    },
    mounted() {
      this.$nextTick(() => {
        this.init()
      })
    },
    methods: {
      init() {
        this.queryRect()
      },
      // ?????????????????????
      updateParentData() {
        this.getParentData('tn-swipe-action')
      },
      // ????????????
      queryRect() {
        this._tGetRect('.tn-swipe-action-item__right__button', true).then(res => {
          this.size = {
            buttons: res,
            show: this.show,
            disabled: this.disabled,
            threshold: this.threshold,
            duration: this.duration
          }
        })
      },
      // ????????????
      buttonClickHandler(item, index) {
        this.$emit('click', {
          type: 'button',
          index,
          name: this.name
        })
      },
      // item??????
      handlerItemClick() {
        this.$emit('click', {
          type: 'item',
          name: this.name
        })
      },
      // ???????????????
      closeHandler() {
        this.status = 'close'
      },
      // ????????????
      setStatus(status) {
        this.status = status
      },
      // ?????????????????????
      closeOther() {
        this.parent && this.parent.closeOther(this)
      }
    }
  }
</script>

<style lang="scss" scoped>
  
  .tn-swipe-action-item {
    position: relative;
    overflow: hidden;
    // touch-action: none;
    
    &__right {
      display: flex;
      flex-direction: row;
      position: absolute;
      top: 0;
      bottom: 0;
      right: 0;
      
      &__button {
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        overflow: hidden;
        
        &__wrapper {
          display: flex;
          flex-direction: row;
          align-items: center;
          justify-content: center;
          padding: 0 30rpx;
        }
        
        &__text {
          display: flex;
          flex-direction: row;
          align-content: center;
          justify-content: center;
          text-align: center;
          color: #FFFFFF;
          font-size: 30rpx;
        }
      }
    }
    
    &__content {
      background-color: #FFFFFF;
      transform: translateX(0px);
    }
  }
</style>
