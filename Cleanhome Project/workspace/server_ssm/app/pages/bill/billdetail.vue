<template>
	<view>
		<u-navbar title="order details" :border="true" :placeholder="true" @leftClick="goBack" :autoBack="false"></u-navbar>
		

		<scroll-view :enable-flex="true" class="svcontainer">
			<view class="formitem">
				<view class="formlabel" style="color: red;">order number:{{fobj.id}}</view>
			</view>
			<view class="formitem">
				<view class="formlabel" style="color: red;">total price:{{fobj.total}}dollars</view>
			</view>
			<view class="formitem">
				<view class="formlabel">Housekeeping Information:{{fobj.gnames}}</view>
			</view>
			<view class="formitem">
				<view class="formlabel" style="color: red;">state:{{fobj.statecn}}</view>
			</view>
			<view class="formitem">
				<view class="formlabel">contact person:{{fobj.address}}</view>
			</view>
			<view class="formitem">
				<view class="formlabel">Shop:{{fobj.shop}}</view>
			</view>
			<!--<view class="formitem">
				<view class="formlabel">order time:{{fobj.ydate}}</view>
			</view>-->
			<view class="formitem" v-if="fobj.qid">
				<view class="formlabel">:{{fobj.qusername+" "+fobj.qtel}}</view>
			</view>
			<view class="formitem">
				<view class="formlabel">order date:{{fobj.ndate}}</view>
			</view>
			<view>
				
				<u-popup :closeable="true" @close="popshow=false" :show="popshow" mode="bottom">
					<view class="dialogctn">
						<u--form>
							
							<view class="formitem">
								<view style="margin-bottom: 30upx;" class="formlabel">Available Coupons:</view>
								<u-radio-group placement="column" @change="toggleTotal">
									<u-radio
										:customStyle="{marginBottom: '15px'}"
										v-for="(item, index) in yhqlist"
										:key="index"
										:label="item.total>0?'coupon amount:'+item.total:'No Coupon/Do Not Use'"
										:name="item.id"
							
									>
									</u-radio>
								</u-radio-group>
							</view>
								
							<view class="formitem">
								<view class="formlabel">payment amount:<text style="color: red;font-size: 40upx;">{{fobj.total}}</text>dollars</view>
							</view>
							<u-form-item borderBottom label-width="76" label="payment password:" prop="passwd">
								<u--input border="none" type="password" v-model="passwd" />
							</u-form-item>
							
							<view class="formitem">
								<button type="primary" @click="payBill()">confirm payment</button>
							</view>
						</u--form>
					</view>
				</u-popup>
			</view>
			<view class="formitem" v-if="fobj.statecn==='obligation'">
				<u-button type="primary" @click="popshow=true" text="Pay"></u-button>
				<view class="hpaddingctn">
					<u-button type="error" @click="changeBillStatecn('canceled')" text="cancel order"></u-button>
				</view>
			</view>
			
			<view class="formitem" v-if="fobj.statecn==='Shipped'">
				<u-button type="primary" @click="changeBillStatecn('waiting for evaluation')" text="Confirm Order"></u-button>
			</view>
			

					
			<view class="hpaddingctn" v-if="fobj.statecn==='waiting for evaluation'">
				<tn-input v-model="rnote" type="textarea" :border="true" :height="100" :autoHeight="true" />
			</view>
			
			<view class="hpaddingctn" v-if="fobj.statecn==='completed'">
				<tn-rate v-model="pingfen" :size="54"></tn-rate>
				<u--textarea v-model="fobj.pnote" placeholder="enter your review" confirmType="done"></u--textarea>
				<u-gap height="10"></u-gap>
				<tn-button @click="pingjia()" backgroundColor="tn-bg-blue" fontColor="#FFFFFF" width="100%">Submit review
				</tn-button>
			</view>
			<view class="hpaddingctn" v-if="fobj.statecn==='evaluated' && !fobj.shstatecn">
				<!--<u-button @click="toShouhou" text="" type="warning"></u-button>-->
			</view>
			<view class="hpaddingctn" v-if="fobj.shstatecn==='Pending'">
				<text class="">:</text>
				<view class="formitem">
					<view class="formlabel">describe:{{fobj.shnote}}</view>
				</view>
				<view class="formitem">
					<view class="formlabel">:{{fobj.shtype}}</view>
				</view>
				<view class="formitem">
					<view class="formlabel" style="color: red;">:{{fobj.shstatecn}}</view>
				</view>
				<u-button @click="qxShouhou" text="" type="warning"></u-button>
			</view>
			<view class="formitem" v-if="fobj.pnote">
				<view class="formlabel">customer reviews:{{fobj.pnote}}</view>
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
				paytotal:0,
				yhq:null,
				yhqlist:[],
				popshow:false,
				fobj: {},
				fobjgoodlist: [],
				fileUrl: fileUrl,
				passwd:'',
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
				this.paytotal = this.fobj.total
				let gids = this.fobj.gids;
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
			this.getYouhuiquan()
		},
		methods: {
			...mapActions(['updateUserInfo']),
			getYouhuiquan(){
				listj({params: {table: 'youhuiquan',uid:this.userInfo.id, statecn:"normal" }}).then(yhl => {
					let yhlist = []
					for (let i = 0; i < yhl.length; i++) {
						let yhq = yhl[i]
						if (yhq.total<=this.fobj.total) {
							yhlist.push(yhq)
						}
					}
					this.yhqlist = yhlist
					
					this.yhqlist.unshift({id:0,total:0})
				}).catch(err => {
				 
				})
			},
			changeBillStatecn:function(statecn){
				this.fobj.statecn = statecn
				savej({params: {table: 'bill', id: this.fobj.id, statecn: statecn}}).then(res => {
					
				}).catch(err => {
				 
				})
			},
			qxShouhou(){
				this.fobj.shstatecn = 'canceled'
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
					url:'/pages/bill/bill'
				})
			},
			toGoodDetail: yewuutil.toGoodDetail,
			
			payBill(){
				let passwd = this.passwd;
				let userpasswd = this.userInfo.passwd
				if(passwd == userpasswd){
					let mymoney = (this.userInfo.money||0)*1
					if (mymoney*1<this.paytotal) {
						uni.showToast({
							icon:'none',
							title: 'Insufficient balance!',
							success:()=>{
								setTimeout(()=>{
									uni.redirectTo({
										url:'/pages/qianbao/charge'
									})
								},1500)
							}
						})
					}else{
						mymoney = mymoney-this.paytotal
						savej({params: {table: 'user', id: this.userInfo.id, money: mymoney }}).then(res => {
							this.userInfo.money = mymoney
							this.updateUserInfo(this.userInfo)
							this.billCommit()
						})
					}
					
				}else{
					uni.showToast({
						title: 'wrong password',
						icon : 'error'
					})
				}
			},
			billCommit(){
				let statecn = 'paid'
				savej({params: {table: 'bill', statecn: statecn, id: this.fobj.id}}).then(res => {
					this.fobj.statecn = statecn
					this.popshow = false
					
					if (this.yhq) {
						savej({params: {table: 'youhuiquan', id:this.yhq.id, statecn: "Used" }})
					}
					uni.showToast({
						icon:'none',
						title: 'Successful operation!'
					})
				}).catch(err => {
				 
				})
			},
			toShouhou(){
				uni.redirectTo({
					url:'billservice?tid='+this.fobj.id
				})
			},
			toggleTotal(n){
				if (n>0) {
					findj({params: {table: 'youhuiquan', id: n}}).then(yhq => {
						this.yhq = yhq
						this.fobj.total=this.paytotal-yhq.total
					}).catch(err => {
					 
					})
				}else{
					this.yhq = null
					this.fobj.total=this.paytotal
				}
				
				
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
