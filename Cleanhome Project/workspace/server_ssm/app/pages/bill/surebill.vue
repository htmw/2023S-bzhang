<template>
	<view>
		
		<u-navbar title="Confirm Order" :border="true" :placeholder="true"   :autoBack="true"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<view class="addressctn">

				 <view class="formitem">
				 	<view class="glabel">Housekeeping Information:{{fobj.gname}}</view>
				 </view>
				 <view class="formitem">
				 	<view class="gtotal">price:{{fobj.price}}</view>
				 </view>
				  <view class="formitem">
					  <view>contact person:</view>
				  	<u-radio-group
				  	   v-model="address"
				  	   placement="column"
				  	 >
				  	   <u-radio
				  	     :customStyle="{marginBottom: '15rpx', marginTop: '15rpx'}"
				  	     v-for="(item,index) in addressList"
				  	     :key="index"
				  	     :label="item.title"
				  	     :name="item.title"
				  	   >
				  	   </u-radio>
				  	 </u-radio-group>
				  </view>


					<ideadatetime v-model="ydate" label="Time"></ideadatetime>
				  <view class="formitem">
					  <u--textarea confirmType="done" v-model="bnote" placeholder="Description" ></u--textarea>
				  </view>		
				  
				  <view class="formitem">
				  	<u-button @click="popshow=true" type="primary" text="confirm payment"></u-button>
				  </view>
				  
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
				  				<view class="formlabel">payment amount:<text style="color: red;font-size: 40upx;">{{paytotal}}</text>dollars</view>
				  			</view>
				  			<u-form-item borderBottom label-width="76" label="payment password:" prop="passwd">
				  				<u--input border="none" type="password" v-model="passwd" />
				  			</u-form-item>
				  			
				  			<view class="formitem">
				  				<button type="primary" @click="payBill()">Pay</button>
				  			</view>
				  		</u--form>
				  	</view>
				  </u-popup>
				  
			</view>
			
		</scroll-view>
	</view>
</template>

<script>
	import {mapState, mapActions} from 'vuex'
	import { listj, findj, savej, fileUrl } from '@/common/config/api.js';
	import { ideautil } from '@/common/commontools.js';
	export default {
		data() {
			return {
				addressList: [],
				bills: [],
				address:'',
				billobj:{},
				bnote:'',
				gnames:'',
				gids: '',
				paytotal:0,
				total:0,
				statecn: 'obligation',
				yhq:null,
				yhqlist:[],
				popshow:false,
				passwd:null,
				paygoodslist:[],
				way: "ship",
				ydate:'',
				fobj:{}
			};
		},
		methods: {
			...mapActions(['updateUserInfo','setCar']),
			tijiaoBtn(){

			},
			goBack(){
				uni.navigateBack({
					delta:1
				})
			},
			selectedAddress(title){
				this.address = title
			},
			
			async billCommit(){
				if(!this.address){
					uni.showToast({
						title: 'Please select a contact'
					})
				}
				let list = this.bills
				//for(let i=0; i < list.length; i++) {
					let obj = {}
					obj.address = this.address
					obj.username = this.userInfo.username
					obj.uid = this.userInfo.id
					obj.note = this.bnote
					obj.user = obj.username
					obj.statecn = this.statecn
					obj.table = 'bill'
					obj.way = this.way
					obj.ydate = this.ydate
					obj.gnames = this.fobj.gname
					obj.sid = this.fobj.sid
					obj.shop = this.fobj.shop
					obj.total = this.paytotal
					await savej({params: obj})
				//}
				if (this.statecn == "paid" && this.yhq) {
					savej({params: {table: 'youhuiquan', id:this.yhq.id, statecn: "used" }})
				}

				/*let carlist = this.carlist
				let goodlist = this.paygoodslist
				let newcarlist = []
				for (let i = 0; i < carlist.length; i++) {
					let cobj = carlist[i]
					let flag = true
					for (let j = 0; j < goodlist.length; j++) {
						let gobj = goodlist[j]
						if (gobj.id == cobj.id) {
							flag = false
							break;
						}
					}
					if (flag) {
						newcarlist.push(cobj)
					}
				}
				this.setCar(newcarlist)*/
				uni.showToast({
					title: 'Successful operation!',
					success:()=>{
						uni.switchTab({
							url: '/pages/bill/bill'
						})
					}
				})

			},
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
									this.billCommit()
								},1500)
							}
						})
					}else{
						mymoney = mymoney-this.paytotal
						savej({params: {table: 'user', id: this.userInfo.id, money: mymoney }}).then(res => {
							this.userInfo.money = mymoney
							this.updateUserInfo(this.userInfo)
							this.statecn = 'paid'
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
			getYouhuiquan(){
				listj({params: {table: 'youhuiquan',uid:this.userInfo.id, statecn:"normal" }}).then(yhl => {
					let yhlist = []
					for (let i = 0; i < yhl.length; i++) {
						let yhq = yhl[i]
						if (yhq.total<=this.paytotal) {
							yhlist.push(yhq)
						}
					}
					this.yhqlist = yhlist

					this.yhqlist.unshift({id:0,total:0})
				}).catch(err => {

				})
			},
			toggleTotal(n){
				if (n>0) {
					findj({params: {table: 'youhuiquan', id: n}}).then(yhq => {
						this.yhq = yhq
						this.paytotal=this.total-yhq.total
					}).catch(err => {

					})
				}else{
					this.yhq = null
					this.paytotal=this.total
				}


			}
		},
		onLoad(){
			this.fobj = getApp().globalData.fobj
			this.total = this.fobj.price
			let uid = this.userInfo.id
			console.log('userid:'+uid)
			listj({params: {table: 'address', uid: uid}}).then(res => {
				this.addressList = res
				this.address = res[0]&&res[0].title
			}).catch(err => {

			})

			/*let list = []
			for (var i = 0; i < this.carlist.length; i++) {
				let gobj = this.carlist[i]
				if (gobj.checked) {
					list.push(gobj)
				}
			}
			let shopslist = []
			for(let i=0; i < list.length; i++) {
				let obj = list[i]
				if (!ideautil.checkStrInList(obj.sid, shopslist)){
					shopslist.push(obj.sid)
				}
			}
			for(let n=0; n < shopslist.length; n++) {
				let sid = shopslist[n]
				let btotal = 0
				let bgnames = ''
				let shopbill = {}
				let bgids = ''
				let bgcounts = ''

				let sname = ''
				for (var i = 0; i < list.length; i++) {
					let obj = list[i]
					if(obj.sid == sid){
						let price = obj.price*1
						let count = obj.count*1
						btotal += price*count
						console.log('---'+JSON.stringify(obj))
						if(bgnames==''){
							bgnames = obj.gname+"*"+count
							bgids = obj.id
							bgcounts = count
						}else{
							bgnames += ","+obj.gname+"*"+count
							bgids += ","+obj.id
							bgcounts += "," + count
						}
						if(sname==''){
							sname = obj.shop
						}
						let mcount = (obj.mcount||0)*1
						if (mcount>=count) {
							mcount -= count
						}else{
							mcount = 0
						}
						this.paygoodslist.push({table: 'good',  mcount:mcount,id:obj.id})
						/!* savej({params: {table: 'good',  mcount:mcount,id:obj.id}}).then(res => {

						}) *!/
					}

				}
				shopbill.total = btotal
				shopbill.gnames = bgnames
				shopbill.gids = bgids
				shopbill.shop = sname
				shopbill.sid = sid
				shopbill.gcounts = bgcounts
				this.bills.push(shopbill)
				if(this.gnames ==''){
					this.gnames = bgnames
				}else {
					this.gnames += ','+bgnames
				}
				this.total+=btotal
				this.paytotal = this.total
			}*/
			this.paytotal = this.total
			this.getYouhuiquan()
		},
		computed: {
			...mapState(['carlist', 'userInfo'])
		}
	}
</script>

<style lang="scss">
.addressctn{
	border-radius: 20upx;
	padding: 10upx;
}
.glabel{
	color: #999;
}
.gtotal{
	color: red;
}
</style>