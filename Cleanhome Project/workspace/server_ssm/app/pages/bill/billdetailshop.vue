<template>
	<view>
		<u-navbar title="订单详情" @leftClick="goBack" :border="true" :placeholder="true"   :autoBack="true"></u-navbar>
		

		<scroll-view :enable-flex="true" class="svcontainer">
			<view class="formitem">
				<view class="formlabel" style="color: red;">Total price:{{fobj.total}}dollars</view>
			</view>
			<view class="formitem">
				<view class="formlabel">Housekeeping Information:{{fobj.gnames}}</view>
			</view>
			<view class="formitem">
				<view class="formlabel" style="color: red;">state:{{fobj.statecn}}</view>
			</view>
			<view class="formitem">
				<view class="formlabel">receive service information:{{fobj.address}}</view>
			</view>
			<view class="formitem">
				<view class="formlabel">order date:{{fobj.ndate}}</view>
			</view>
			<view class="formitem" v-if="fobj.kdgs">
				<view class="formlabel">delivery information:{{fobj.kdgs+" "+fobj.kddh}}</view>
			</view>
			<view>
				
				<u-popup :closeable="true" @close="popshow=false" :show="popshow" mode="bottom">
					<view class="dialogctn">
						<form>
							<u-form-item borderBottom label-width="76" label="Express company:" prop="kdgs">
								<u--input border="none" v-model="fobj.kdgs" />
							</u-form-item>
							<u-form-item borderBottom label-width="76" label="tracking number:" prop="kddh">
								<u--input border="none" v-model="fobj.kddh" />
							</u-form-item>
						</form>
						<view class="formitem">
							<view class="hpaddingctn">
								<u-button type="primary" text="Confirm delivery" @click="fahuo()" />
							</view>
						</view>
					</view>
				</u-popup>
			</view>
			<view class="formitem" v-if="fobj.statecn==='paid'">
				<u-button type="primary" @click="popshow=true" text="ship immediately"></u-button>
				<view class="hpaddingctn">
					<u-button type="error" @click="changeBillStatecn('canceled')" text="cancel order"></u-button>
				</view>
			</view>
			
			
			
			<view class="hpaddingctn" v-if="fobj.shstatecn">
				<text class="">After-sales details:</text>
				<view class="formitem">
					<view class="formlabel">describe:{{fobj.shnote}}</view>
				</view>
				<view class="formitem">
					<view class="formlabel">After-sales method:{{fobj.shtype}}</view>
				</view>
				<view class="formitem">
					<view class="formlabel" style="color: red;">After-sales status:{{fobj.shstatecn}}</view>
				</view>
				<view v-if="fobj.shstatecn==='Pending'">
					<view class="hpaddingctn">
						<u-button @click="doShouhou('Agree after-sale')" text="agree" type="warning"></u-button>
					</view>
					<view class="hpaddingctn">
						<u-button @click="doShouhou('Refusal after-sale')" text="refusal" type="error"></u-button>
					</view>
					
				</view>				
			</view>
			<view class="formitem" v-if="fobj.pnote">
				<view class="formlabel">Customer reviews:{{fobj.pnote}}</view>
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
				popshow:false,
				fobj: {},
				fobjgoodlist: [],
				fileUrl: fileUrl,
				pingfen:0,
				rnote:''
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
					
				}).catch(err => {
				 
				})
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
				uni.switchTab({
					url:'/pages/bill/billshop'
				})
			},
			toGoodDetail: yewuutil.toGoodDetail,
			
			fahuo(){
				let passwd = this.passwd;
				let userpasswd = this.userInfo.passwd
				
				this.fobj.statecn = 'Shipped'
				savej({params: {table: 'bill', statecn: this.fobj.statecn, id: this.fobj.id,kdgs:this.fobj.kdgs,kddh:this.fobj.kddh}}).then(res => {
					this.popshow = false
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
