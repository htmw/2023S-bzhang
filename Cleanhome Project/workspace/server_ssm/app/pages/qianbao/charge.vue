<template>
	<view>
		<u-navbar title="recharge" :border="true" :placeholder="true"   :autoBack="true"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<u--form labelPosition="left" ref="cform">
				<u-form-item borderBottom label-width="76" label="Recharge amount:" prop="money">
					<u--input type="number" border="none" v-model="money" />
				</u-form-item>
				<u-form-item prop="sex" @click="asshow = true;hideKeyboard();" borderBottom label-width="76" label="Recharge method:">
					<u--input border="none" type="select" v-model="paytype" />
					<u-icon slot="right" name="arrow-right"></u-icon>
					<u-action-sheet :show="asshow" :actions="[{name:'wechat payment',id: 1}, {name:'Alipay', id:2}, {name:'credit card', id:2}]" title="Choose recharge method" description="Choose recharge method" @close="asshow = false" @select="asSelect" />
				</u-form-item>
			</u--form>
			<view class="hpaddingctn">
				<u-button type="primary" text="confirme" @click="charge" />
			</view>
		</scroll-view>
	</view>
</template>

<script>
	import { listj, findj, savej, fileUrl, saveWxUser, uploadUrl } from '@/common/config/api.js'
	import {mapState, mapActions} from 'vuex'
	import ideaUpload from '@/components/idea-upload/idea-upload.vue'
	import { ideautil, yewuutil } from '@/common/commontools.js'
	export default {
		components: {ideaUpload},
		data() {
			return {
				asshow:false,
				money:100,
				paytype:"wechat pay"
			}
		},
		onLoad() {
			
		},
		methods: {
			...mapActions(['updateUserInfo']),
			hideKeyboard: ideautil.hideKeyboard,
			asSelect(v){
				this.paytype = v.name
			},
			charge(){
				if (this.money>0) {
					let ol = this.userInfo.money || 0
					let nl = ol*1+this.money*1
					this.userInfo.money = nl
					this.updateUserInfo(this.userInfo)
					savej({params: {table: 'user', id: this.userInfo.id, money: nl }}).then(res => {
						uni.switchTab({
							url:'/pages/me/me'
						})
					})
					
				}
			}
		},
		computed: {
			...mapState(['userInfo'])
		}
	}
</script>

<style lang="scss">

</style>
