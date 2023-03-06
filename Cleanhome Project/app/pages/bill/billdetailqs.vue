<template>
	<view>
		<u-navbar title="订单详情" :border="true" :placeholder="true" @leftClick="goBack" :autoBack="false"></u-navbar>
		

		<scroll-view :enable-flex="true" class="svcontainer">
			<view class="formitem">
				<view class="formlabel" style="color: red;">总价:{{fobj.total}}元</view>
			</view>
			<view class="formitem">
				<view class="formlabel">家政信息:{{fobj.gnames}}</view>
			</view>
			<view class="formitem">
				<view class="formlabel" style="color: red;">状态:{{fobj.statecn}}</view>
			</view>
			<view class="formitem">
				<view class="formlabel">联系人:{{fobj.address}}</view>
			</view>
			<!--<view class="formitem">
				<view class="formlabel" style="color: red;">订单时间:{{fobj.ydate}}</view>
			</view>-->
			<view class="formitem">
				<view class="formlabel">订单日期:{{fobj.ndate}}</view>
			</view>
			<view class="formitem" v-if="fobj.qid">
				<view class="formlabel">配送员信息:{{fobj.qusername+" "+fobj.qtel}}</view>
			</view>
			<view class="formitem" v-if="fobj.statecn==='paid'">
				<view class="hpaddingctn">
					<view class="formitem">
						<u-button type="success" @click="changeBillStatecn('Received')" text="接单"></u-button>
					</view>

					<!--<u-button type="error" @click="changeBillStatecn('已拒绝')" text="已拒绝"></u-button>-->
				</view>
			</view>
			<view class="formitem" v-if="fobj.statecn==='Received'">
				<view class="hpaddingctn">
					<u-button type="error" @click="changeBillStatecn('completed')" text="completed"></u-button>
				</view>
			</view>

			
			<view class="formitem" v-if="fobj.pnote">
				<view class="formlabel">客户评论:{{fobj.pnote}}</view>
			</view>
			<view>
				<view @click="toGoodDetail(item.id, 1)" class="caritem" v-for="(item,index) in fobjgoodlist" :key="index">
					<image class="carimg" :src="fileUrl+item.img"></image>
					<view class="carinfo">
						<view class="cartitle">{{item.gname}}</view>
						<view class="carpricectn">
							<view class="carprice">price:{{item.price}}</view>
						</view>
					</view>
				</view>
			</view>
		</scroll-view>
	</view>
</template>

<script>
	import {
		listj,
		findj,
		savej,
		listSqlj,
		deletej,
		fileUrl
	} from '@/common/config/api.js';
	import { ideautil, yewuutil } from '@/common/commontools.js';
	import {
		mapState,
		mapActions
	} from 'vuex'
	export default {
		data() {
			return {
				fobj: {},
				fobjgoodlist: [],
				fileUrl: fileUrl,
				pingfen:0,
				rnote:'',
				money:2
			};
		},
		onLoad(params) {
			let bid = params.bid
			findj({
				params: {
					table: 'bill',
					id: bid
				}
			}).then(res => {
				this.fobj = res
				this.fobj.table = "bill"
				let gids = this.fobj.gids
				let sql = `select * from wct_good where id in (${gids})`;
				listSqlj({
					params: {
						sql: sql
					}
				}).then(glist => {
					this.fobjgoodlist = glist
				}).catch(err => {

				})
			}).catch(err => {})
		},
		methods: {
			...mapActions(['updateUserInfo']),
			changeBillStatecn:function(statecn){
				this.fobj.statecn = statecn
				savej({params: {table: 'bill', id: this.fobj.id, statecn: statecn}}).then(res => {
					this.charge()
				}).catch(err => {
				 
				})
			},
			charge(){
				if (this.money>0) {
					let ol = this.userInfo.money || 0
					let nl = ol*1+this.money*1
					this.userInfo.money = nl
					this.updateUserInfo(this.userInfo)
					savej({params: {table: 'user', id: this.userInfo.id, money: nl }}).then(res => {
						/* uni.switchTab({
							url:'/pages/me/me'
						}) */
					})
					
				}
			},
			doShouhou(statecn){
				this.fobj.shstatecn = statecn
				savej({params: {table: 'bill', id: this.fobj.id, shstatecn: this.fobj.shstatecn}}).then(res => {
					
				}).catch(err => {
				 
				})
			},
			
			pingjia:function(){
				this.fobj.statecn = "evaluated"
				this.fobj.pnote = this.rnote
				this.fobj.pf = this.pingfen
				savej({params: {table: 'bill',id: this.fobj.id, pf: this.fobj.pf, pnote: this.fobj.pnote, statecn: this.fobj.statecn}}).then(res => {
					
				}).catch(err => {
				 
				})
			},

			goBack() {
				uni.redirectTo({
					url:'/pages/bill/billqs'
				})
			},
			toGoodDetail: yewuutil.toGoodDetail,
			inputDialogToggle() {
				this.$refs.inputDialog.open('bottom')
			},
			jiedan(){
				this.fobj.qid = this.userInfo.id
				this.fobj.qusername = this.userInfo.username
				this.fobj.qtel = this.userInfo.tel
				this.fobj.statecn = 'Received'
				savej({params: {table: 'bill', statecn: this.fobj.statecn, id: this.fobj.id,qid:this.fobj.qid,qusername:this.fobj.qusername,qtel:this.fobj.qtel}}).then(res => {
					this.$refs.inputDialog.close()
				}).catch(err => {
				 
				})
				
			},
			toShouhou(){
				uni.redirectTo({
					url:'billservice?tid='+this.fobj.id
				})
			}
		},
		computed: {
			...mapState(['userInfo'])
		}
	}
</script>

<style lang="scss">
	.caritem {
		display: flex;
		width: 100%;
		height: 200upx;
		background-color: #fafafa;
		align-items: center;
		padding: 10upx;
		margin: 10upx 0;
	}

	.carimg {
		width: 180upx;
		height: 180upx;
		margin-right: 10upx;
	}

	.carinfo {
		height: 100%;
		display: flex;
		flex-direction: column;
		justify-content: space-around;
		flex: 1;
	}

	.cartitle {
		font-size: 26upx;
	}

	.carpricectn {
		display: flex;
		justify-content: space-between;
		width: 100%;
	}

	.carprice {
		color: red;
		font-size: 25upx;
	}
</style>
