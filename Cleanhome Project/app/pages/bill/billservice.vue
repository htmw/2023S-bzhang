<template>
	<view>
		<u-navbar title="申请售后" :border="true" :placeholder="true"   :autoBack="true"></u-navbar>
		

		<scroll-view :enable-flex="true" class="svcontainer">
			<u--form>
				<u-form-item label="描述"  borderBottom ref="item1">
					<u--input v-model="shnote" border="none"></u--input>
				</u-form-item>
			</u--form>
			<view class="u-demo-block">
				<text class="iblocktitle">选择售后方式:</text>
				<view>
					<view class="u-page__radio-item">
						<u-radio-group v-model="shtype" :borderBottom="true" placement="column" iconPlacement="right">
							<u-radio :customStyle="{marginBottom: '16px'}" v-for="(item, index) in shtypelist" :key="index" :label="item.name" :name="item.name"></u-radio>
						</u-radio-group>
					</view>
				</view>
			</view>

			<!-- <view class="formitem">
				<view class="formlabel">配图:</view>
				<ideaUpload :filelist="filelist" @getUploadImg="getUploadImg"></ideaUpload>
			</view> -->
			
			
			<view class="formitem">
				<u-button type="primary" @click="saveBillSh()" text="提交"></u-button>
			</view>

		</scroll-view>
	</view>
</template>

<script>
	import {
		listj,
		findj,
		savej,
		deletej,
		fileUrl,
		uploadUrl
	} from '@/common/config/api.js';
	import {
		mapState,
		mapActions
	} from 'vuex';
	import ideaUpload from '@/components/idea-upload/idea-upload.vue';
	export default {
		components: {
			ideaUpload
		},
		data() {
			return {
				focusobj:{},
				tel: '',
				typelist: [],
				filelist: [],
				tid: null,
				fileUrl: fileUrl,
				uploadUrl: uploadUrl,
				shnote:'',
				shtypelist: [{
						name: '退货',
						disabled: false
					},
					{
						name: '换货',
						disabled: false
					},
				],
				// u-radio-group的v-model绑定的值如果设置为某个radio的name，就会被默认选中
				shtype: '退货'
			};
		},
		onLoad(params) {
			if (params.tid && params.tid !== 'undefined') {
				this.tid = params.tid

			}
			console.log('tttttttid:' + params.tid + " showdel:" + this.showdel)
			if (this.tid) {
				findj({
					params: {
						table: 'bill',
						id: this.tid
					}
				}).then(res => {
					this.focusobj = res
				}).catch(err => {

				})
			}
		},
		methods: {
			saveBillSh(){
				savej({params: { table: "bill", id: this.focusobj.id, shnote:this.shnote, shtype: this.shtype, shstatecn: '待处理'}}).then(res => {
					uni.redirectTo({
						url:'/pages/bill/billdetail?bid='+this.focusobj.id
					})
				}).catch(err => {
				 
				})
			},
			goBack(){
				uni.navigateBack({
					delta:1
				})
			}
		},
		computed: {
			...mapState(['userInfo'])
		}
	}
</script>

<style lang="scss">
	
</style>
