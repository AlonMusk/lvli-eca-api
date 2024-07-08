
--
-- 数据库： `dxch_dev`
--

-- --------------------------------------------------------

--
-- 表的结构 `dxch_act`
--

CREATE TABLE `dxch_act` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `title` varchar(20) NOT NULL COMMENT '标题',
  `type` int(4) DEFAULT '0' COMMENT '类型 0：优惠券 1：满赠 2：满减 3：限时秒杀 4:活动弹窗',
  `can_union` int(4) DEFAULT '0' COMMENT '是否可重叠使用 0：否',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '链接',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '内容',
  `rule_id` int(4) DEFAULT '0' COMMENT '规则ID',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动主表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_act_rule`
--

CREATE TABLE `dxch_act_rule` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `act_id` int(4) DEFAULT '0' COMMENT '活动ID',
  `num` int(4) DEFAULT '0' COMMENT '数量：折扣:N%金额 满赠N件SKU 满减N元 秒杀：N元价格',
  `type` int(4) DEFAULT '0' COMMENT '0:金额 1:件数',
  `start_at` int(11) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_at` int(11) NOT NULL DEFAULT '0' COMMENT '结束时间',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动规则表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_act_spu`
--

CREATE TABLE `dxch_act_spu` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `act_id` int(4) DEFAULT '0' COMMENT '活动ID',
  `is_all` int(4) DEFAULT '0' COMMENT '是否全部商品参加活动',
  `brand_id` int(4) DEFAULT '0' COMMENT '商品品牌',
  `cat_id` int(4) DEFAULT '0' COMMENT '商品分类',
  `spu_id` varchar(255) DEFAULT '' COMMENT '商品ID',
  `sku_id` varchar(255) DEFAULT '' COMMENT 'skuID',
  `stock` int(4) DEFAULT '0' COMMENT '活动库存',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动商品表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_act_user`
--

CREATE TABLE `dxch_act_user` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `act_id` int(4) DEFAULT '0' COMMENT '活动ID',
  `is_all` int(4) DEFAULT '0' COMMENT '是否全部参加活动',
  `level` int(4) DEFAULT '0' COMMENT '用户等级',
  `user_id` varchar(255) DEFAULT '' COMMENT '用户ID',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='活动用户表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_area`
--

CREATE TABLE `dxch_area` (
  `id` int(11) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `code` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `cname` varchar(255) DEFAULT NULL,
  `lower_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `dxch_article`
--

CREATE TABLE `dxch_article` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `name` varchar(100) NOT NULL COMMENT '文章名',
  `title` varchar(100) NOT NULL COMMENT '文章标题',
  `main_img` varchar(255) NOT NULL COMMENT '封面图',
  `type` int(4) DEFAULT '0' COMMENT '文章类型 0:默认  1:关于我们  2:产品预定协议  3:隐私协议',
  `cat_id` int(4) DEFAULT '0' COMMENT '分类ID',
  `group_id` varchar(255) DEFAULT '' COMMENT '分组ID',
  `content` mediumtext COMMENT '文章内容',
  `is_new` int(4) DEFAULT '0' COMMENT '是否最新',
  `sort` int(4) DEFAULT '1' COMMENT '排序',
  `status` int(4) DEFAULT '1' COMMENT '状态 1:上架 0:下架',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_attr`
--

CREATE TABLE `dxch_attr` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '标题',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品属性表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_balance_details`
--

CREATE TABLE `dxch_balance_details` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号/订单号',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `card_id` int(4) DEFAULT '0' COMMENT 'card_id',
  `balance_change` int(4) DEFAULT '0' COMMENT '变更金额',
  `balance` int(4) DEFAULT '0' COMMENT '变更后金额',
  `change_at` timestamp NULL DEFAULT NULL COMMENT '变更时间',
  `pay_type` int(4) DEFAULT '0' COMMENT '支付方式',
  `note` varchar(50) DEFAULT '' COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='余额明细表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_balance_withdraw`
--

CREATE TABLE `dxch_balance_withdraw` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号/订单号',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `card_id` int(4) DEFAULT '0' COMMENT 'card_id',
  `withdraw_balance` int(4) DEFAULT '0' COMMENT '提现金额',
  `pay_balance` int(4) DEFAULT '0' COMMENT '打款金额',
  `withdraw_type` int(4) DEFAULT '0' COMMENT '提现方式',
  `account` varchar(50) NOT NULL COMMENT '收款账号',
  `identity` varchar(50) NOT NULL COMMENT '身份信息',
  `withdraw_at` timestamp NULL DEFAULT NULL COMMENT '提现时间',
  `status` int(4) DEFAULT '0' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='余额提现表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_bonus_records`
--

CREATE TABLE `dxch_bonus_records` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号/订单号',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `card_id` int(4) DEFAULT '0' COMMENT 'card_id',
  `bonus_balance` int(4) DEFAULT '0' COMMENT '分红金额',
  `settlement_at` timestamp NULL DEFAULT NULL COMMENT '结算时间',
  `note` varchar(50) DEFAULT '' COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分红记录表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_brand`
--

CREATE TABLE `dxch_brand` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '标题',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品品牌表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_cart`
--

CREATE TABLE `dxch_cart` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `mem_id` int(4) DEFAULT '0' COMMENT 'mem_id',
  `old_price` int(4) DEFAULT '0' COMMENT '原价',
  `price` int(4) DEFAULT '0' COMMENT '价格',
  `num` int(4) DEFAULT '0' COMMENT '数量',
  `num_unit` int(4) DEFAULT '0' COMMENT '单位',
  `attr_id` varchar(255) DEFAULT '' COMMENT '属性ID',
  `tag_id` varchar(255) DEFAULT '' COMMENT '标签ID',
  `content` varchar(255) NOT NULL COMMENT '详情页',
  `act_id` int(4) DEFAULT '0' COMMENT '活动ID',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_cat`
--

CREATE TABLE `dxch_cat` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `title` varchar(20) DEFAULT '' COMMENT '标题',
  `main_img` varchar(255) DEFAULT '' COMMENT '封面图',
  `content` varchar(255) DEFAULT '' COMMENT '描述',
  `fid` int(4) DEFAULT '0' COMMENT '父ID',
  `cid` int(4) DEFAULT '0' COMMENT '子ID',
  `level` int(4) DEFAULT '0' COMMENT '层级',
  `sort` int(4) DEFAULT '0' COMMENT '序号',
  `icon` varchar(255) DEFAULT '' COMMENT 'icon',
  `type` int(4) DEFAULT '0' COMMENT '类型 1:出行 2:基础服务',
  `url` varchar(255) DEFAULT '' COMMENT '跳转链接',
  `status` int(4) DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品分类表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_cities`
--

CREATE TABLE `dxch_cities` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `state_id` smallint(6) NOT NULL COMMENT '所属州省代码',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lower_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_full` char(9) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地区代码',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `dxch_commission_agent`
--

CREATE TABLE `dxch_commission_agent` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号/订单号',
  `user_id` int(11) NOT NULL COMMENT '用户',
  `level` int(11) NOT NULL COMMENT '分销商等级',
  `apply_info` text COMMENT '申请信息',
  `total_income` int(11) NOT NULL DEFAULT '0' COMMENT '总收益',
  `child_order_money_0` int(11) NOT NULL DEFAULT '0' COMMENT '自购/直推分销订单金额',
  `child_order_money_1` int(11) NOT NULL DEFAULT '0' COMMENT '一级分销订单总金额',
  `child_order_money_2` int(11) NOT NULL DEFAULT '0' COMMENT '二级分销订单总金额',
  `child_order_money_all` int(11) NOT NULL DEFAULT '0' COMMENT '团队分销订单总金额',
  `child_order_count_0` int(11) NOT NULL DEFAULT '0' COMMENT '自购/直推分销订单数量',
  `child_order_count_1` int(11) NOT NULL DEFAULT '0' COMMENT '一级分销订单数量',
  `child_order_count_2` int(11) NOT NULL DEFAULT '0' COMMENT '二级分销订单数量',
  `child_order_count_all` int(11) NOT NULL DEFAULT '0' COMMENT '团队分销订单数量',
  `child_agent_count_1` int(11) NOT NULL DEFAULT '0' COMMENT '直推分销商人数',
  `child_agent_count_2` int(11) NOT NULL DEFAULT '0' COMMENT '二级分销商人数',
  `child_agent_count_all` int(11) NOT NULL DEFAULT '0' COMMENT '团队分销商人数',
  `child_agent_level_1` varchar(255) DEFAULT '' COMMENT '一级分销商等级统计',
  `child_agent_level_all` varchar(255) DEFAULT '' COMMENT '团队分销商等级统计',
  `child_user_count_1` int(11) NOT NULL DEFAULT '0' COMMENT '一级用户人数',
  `child_user_count_2` int(11) NOT NULL DEFAULT '0' COMMENT '二级用户人数',
  `child_user_count_all` int(11) NOT NULL DEFAULT '0' COMMENT '团队用户人数',
  `upgrade_lock` tinyint(4) NOT NULL DEFAULT '0' COMMENT '升级锁定:0=不锁定,1=锁定',
  `apply_num` int(11) NOT NULL DEFAULT '0' COMMENT '提交申请次数',
  `level_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '升级状态:0=不升级,>1=待升级等级',
  `status` int(4) DEFAULT '1' COMMENT '分销商状态:默认1: normal正常 0:forbidden禁用,2:pending审核中,3:freeze=冻结,4:reject=拒绝',
  `become_at` int(10) DEFAULT NULL COMMENT '成为分销商时间',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分销商';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_commission_details`
--

CREATE TABLE `dxch_commission_details` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号/订单号',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `card_id` int(4) DEFAULT '0' COMMENT 'card_id',
  `commission_source` int(4) DEFAULT '0' COMMENT '佣金来源',
  `balance_change` int(4) DEFAULT '0' COMMENT '变更金额',
  `balance` int(4) DEFAULT '0' COMMENT '变更后金额',
  `change_at` timestamp NULL DEFAULT NULL COMMENT '变更时间',
  `pay_type` int(4) DEFAULT '0' COMMENT '支付方式',
  `note` varchar(50) DEFAULT '' COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='佣金明细表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_commission_records`
--

CREATE TABLE `dxch_commission_records` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号/订单号',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `card_id` int(4) DEFAULT '0' COMMENT 'card_id',
  `commission_balance` int(4) DEFAULT '0' COMMENT '佣金金额',
  `commission_source` int(4) DEFAULT '0' COMMENT '佣金来源 1:订单佣金',
  `commission_integral` int(4) DEFAULT '0' COMMENT '佣金积分',
  `commission_at` timestamp NULL DEFAULT NULL COMMENT '发放时间',
  `status` int(4) DEFAULT '0' COMMENT '状态 0:未发放  1:已发放',
  `order_status` int(4) DEFAULT '0' COMMENT '订单状态',
  `note` varchar(50) DEFAULT '' COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='佣金记录表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_commission_withdraw`
--

CREATE TABLE `dxch_commission_withdraw` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号/订单号',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `card_id` int(4) DEFAULT '0' COMMENT 'card_id',
  `withdraw_balance` int(4) DEFAULT '0' COMMENT '提现金额',
  `pay_balance` int(4) DEFAULT '0' COMMENT '打款金额',
  `withdraw_type` int(4) DEFAULT '0' COMMENT '提现方式',
  `account` varchar(50) NOT NULL COMMENT '收款账号',
  `identity` varchar(50) NOT NULL COMMENT '身份信息',
  `withdraw_at` timestamp NULL DEFAULT NULL COMMENT '提现时间',
  `status` int(4) DEFAULT '0' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='佣金提现表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_consumption_details`
--

CREATE TABLE `dxch_consumption_details` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号/订单号',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `pay_project` varchar(50) DEFAULT '' COMMENT '支付项目',
  `pay_price` int(4) DEFAULT '0' COMMENT '支付金额',
  `pay_type` int(4) DEFAULT '0' COMMENT '支付方式',
  `pay_at` timestamp NULL DEFAULT NULL COMMENT '付款时间',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='消费明细表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_continents`
--

CREATE TABLE `dxch_continents` (
  `id` int(8) UNSIGNED NOT NULL COMMENT '自增id',
  `name` varchar(16) DEFAULT NULL COMMENT '英文名',
  `cname` varchar(16) DEFAULT NULL COMMENT '中文名',
  `lower_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `dxch_countries`
--

CREATE TABLE `dxch_countries` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `continent_id` int(11) DEFAULT NULL,
  `code` char(3) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地区代码',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_cname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lower_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `dxch_custom_form`
--

CREATE TABLE `dxch_custom_form` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(20) DEFAULT '' COMMENT '表单名称',
  `type` int(4) DEFAULT '0' COMMENT '表单类型 1：出行人',
  `is_active` int(4) DEFAULT '1' COMMENT '是否启用 1：是 0：否',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='自定义表单表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_dest`
--

CREATE TABLE `dxch_dest` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `title` varchar(20) DEFAULT '' COMMENT '标题',
  `main_img` varchar(255) NOT NULL COMMENT '封面图',
  `content` varchar(255) DEFAULT '' COMMENT '描述',
  `dest_id` int(4) DEFAULT '0' COMMENT '第三方ID',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品目的地表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_dis`
--

CREATE TABLE `dxch_dis` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `user_id` int(4) DEFAULT '0' COMMENT '邀请人userID',
  `fid` int(4) DEFAULT '0' COMMENT '被邀请人的父ID',
  `cid` int(4) DEFAULT '0' COMMENT '被邀请人ID',
  `level` int(4) DEFAULT '0' COMMENT '被邀请人所在的层级',
  `start_at` timestamp NULL DEFAULT NULL COMMENT '邀请时间',
  `type` int(4) DEFAULT '0' COMMENT ' 1：邀请注册 2：邀请下单',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分销表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_dis_conditions`
--

CREATE TABLE `dxch_dis_conditions` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `field_name` varchar(255) NOT NULL,
  `operator` enum('==','!=','>=','<=','<','>') NOT NULL,
  `value` varchar(255) NOT NULL,
  `rule_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='条件表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_dis_rule`
--

CREATE TABLE `dxch_dis_rule` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `dis_id` int(4) DEFAULT '0' COMMENT '分销ID',
  `num` int(4) DEFAULT '0' COMMENT 'N金额 N人 N酒',
  `unit` int(4) DEFAULT '0' COMMENT '0:元  2：人 3：瓶 4：件',
  `return_num` int(4) DEFAULT '0' COMMENT 'N金额 N% N酒 ',
  `return_unit` int(4) DEFAULT '0' COMMENT '0:元 1：百分比金额  3：瓶 4：件',
  `can_union` int(4) DEFAULT '0' COMMENT '规则是否可以重叠使用',
  `start_at` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `end_at` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分销规则表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_dis_rules`
--

CREATE TABLE `dxch_dis_rules` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `type` enum('AND','OR') NOT NULL,
  `description` varchar(255) DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规则表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_dis_rule_conditions`
--

CREATE TABLE `dxch_dis_rule_conditions` (
  `rule_id` int(11) NOT NULL,
  `condition_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规则-条件关系表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_dis_rule_hierarchy`
--

CREATE TABLE `dxch_dis_rule_hierarchy` (
  `parent_rule_id` int(11) NOT NULL,
  `child_rule_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规则层次关系表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_end_user`
--

CREATE TABLE `dxch_end_user` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `nickname` varchar(10) DEFAULT NULL COMMENT '昵称',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `openid` varchar(50) NOT NULL DEFAULT '' COMMENT '授权ID',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `phone` char(15) DEFAULT NULL COMMENT '手机',
  `level` int(4) DEFAULT '0' COMMENT '等级 0:普通用户/游客',
  `is_new` int(4) DEFAULT '0' COMMENT '是否是新用户',
  `wallet` int(4) DEFAULT '0' COMMENT '钱包金额',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  `api_token` varchar(255) DEFAULT '' COMMENT 'token',
  `remember_token` varchar(255) DEFAULT '' COMMENT 'remember_token'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台用户表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_evaluate`
--

CREATE TABLE `dxch_evaluate` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `spu_id` int(4) DEFAULT '0' COMMENT '产品ID',
  `order_id` int(4) DEFAULT '0' COMMENT '订单ID',
  `user_id` int(4) DEFAULT '0' COMMENT '评价用户ID',
  `user_avatar` varchar(255) DEFAULT '' COMMENT '用户头像',
  `user_nickname` varchar(255) DEFAULT '' COMMENT '用户昵称',
  `is_virtual` int(4) DEFAULT '0' COMMENT '是否是虚拟用户 1:是 0:否',
  `score` int(4) DEFAULT '0' COMMENT '打分',
  `images` varchar(255) DEFAULT '' COMMENT '上传图片',
  `content` varchar(255) DEFAULT '' COMMENT '评价内容',
  `reply_content` varchar(255) DEFAULT '' COMMENT '商家回复内容',
  `reply_time` timestamp NULL DEFAULT NULL COMMENT '商家回复时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品评价表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_finance`
--

CREATE TABLE `dxch_finance` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `amount` int(4) DEFAULT '0' COMMENT '总账金额',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='财务主表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_font_user`
--

CREATE TABLE `dxch_font_user` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `nickname` varchar(10) DEFAULT NULL COMMENT '昵称',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `openid` varchar(50) DEFAULT '' COMMENT '授权ID',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `phone` char(15) DEFAULT NULL COMMENT '手机',
  `wechat_phone` char(15) DEFAULT NULL COMMENT '用户微信授权手机',
  `level` int(4) DEFAULT '0' COMMENT '等级 0:普通用户/游客',
  `is_new` int(4) DEFAULT '0' COMMENT '是否是新用户',
  `wallet` int(4) DEFAULT '0' COMMENT '钱包金额',
  `commission` int(4) DEFAULT '0' COMMENT '佣金',
  `source` int(4) DEFAULT '0' COMMENT '来源 0:未知 1:小程序',
  `parent_user_id` int(4) DEFAULT '0' COMMENT '上级用户id',
  `invite_code` varchar(20) NOT NULL DEFAULT '' COMMENT '邀请码',
  `has_wx_user_info` int(4) DEFAULT '0' COMMENT '用户是否授权了头像和昵称 0:否 1:是',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  `api_token` varchar(255) DEFAULT '' COMMENT 'token',
  `remember_token` varchar(255) DEFAULT '' COMMENT 'remember_token'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='前台用户表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_font_virtual_user`
--

CREATE TABLE `dxch_font_virtual_user` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `nickname` varchar(10) DEFAULT '' COMMENT '昵称',
  `avatar` varchar(255) DEFAULT '' COMMENT '头像',
  `phone` char(15) DEFAULT '' COMMENT '手机',
  `level` int(4) DEFAULT '0' COMMENT '等级 0:普通用户/游客',
  `status` int(11) DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='前台虚拟用户表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_form_fields`
--

CREATE TABLE `dxch_form_fields` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `user_id` int(4) DEFAULT '0' COMMENT '用户ID',
  `form_id` int(4) NOT NULL COMMENT '表单ID',
  `sort` int(4) DEFAULT '0' COMMENT '排序',
  `name` varchar(20) NOT NULL COMMENT '字段名称',
  `type` int(4) DEFAULT '1' COMMENT '组件类型 (1:单行输入 2:多行输入 3:单项选择 4：多项选择 5：普通选择 6：时间选择 7：日期选择 8：省市区选择 9：上传图片)',
  `param_json` text COMMENT '组件参数',
  `default_value` varchar(255) DEFAULT '' COMMENT '默认值',
  `required` int(4) DEFAULT '1' COMMENT '是否必填 1：是 0：否',
  `value` varchar(255) NOT NULL COMMENT '值',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='表单字段表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_group`
--

CREATE TABLE `dxch_group` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `main_img` varchar(255) DEFAULT '' COMMENT '封面图',
  `sort` int(4) DEFAULT '0' COMMENT '序号',
  `status` int(4) DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品分组表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_insured_person`
--

CREATE TABLE `dxch_insured_person` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `user_id` int(4) NOT NULL COMMENT '用户ID',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `sex` int(4) DEFAULT '0' COMMENT '性别 1：男 0：女',
  `id_type` int(4) DEFAULT '0' COMMENT '证件类型 0:身份证 1:护照',
  `id_no` varchar(20) NOT NULL COMMENT '证件号码',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='投保人表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_invoice`
--

CREATE TABLE `dxch_invoice` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号/订单号',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `invoice_amount` int(4) DEFAULT '0' COMMENT '可开票金额',
  `invoice_type` int(4) DEFAULT '0' COMMENT '发票类型',
  `invoice_title_type` int(4) DEFAULT '0' COMMENT '抬头类型',
  `invoice_title` varchar(50) NOT NULL COMMENT '发票抬头',
  `invoice_content` varchar(50) NOT NULL COMMENT '发票内容',
  `invoice_taxpayer` varchar(50) NOT NULL COMMENT '纳税人识别号',
  `invoice_address` varchar(50) NOT NULL COMMENT '注册地址',
  `invoice_bank` varchar(50) NOT NULL COMMENT '开户银行',
  `invoice_phone` varchar(50) NOT NULL COMMENT '手机号',
  `invoice_email` varchar(50) NOT NULL COMMENT '邮箱',
  `status` int(4) DEFAULT '0' COMMENT '状态',
  `invoice_at` timestamp NULL DEFAULT NULL COMMENT '开票时间',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='发票表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_member_card`
--

CREATE TABLE `dxch_member_card` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `sort` int(4) DEFAULT '0' COMMENT '用于升级顺序判断，数字越大等级越高',
  `name` varchar(20) NOT NULL COMMENT '卡名(等级名称)',
  `main_img` varchar(255) DEFAULT '' COMMENT '等级图标',
  `discount` int(4) DEFAULT '10' COMMENT '折扣(10表示不打折,9.5表示打九五折)',
  `limit` int(4) DEFAULT '0' COMMENT '人数限制。达到人数限制将不可申请和自动升级到该等级,0表示不限制',
  `can_apply` int(4) DEFAULT '0' COMMENT '是否可申请 0：否  1： 是。 是否可以由用户主动提交申请资料申请成为该级别',
  `upgrade_fee` int(4) DEFAULT '0' COMMENT '升级费用。提交申请时需要交升级费,0代表免费申请',
  `upgrade_fee_distribution` int(4) DEFAULT '0' COMMENT '升级费用是否参与分销 0：否 1：是 ',
  `apply_audit` int(4) DEFAULT '0' COMMENT '申请资料是否需要后台审核  0：否 1：是  ',
  `apply_setting_id` int(4) DEFAULT '0' COMMENT '申请资料设置 关联 会员卡申请资料表',
  `auto_upgrade` int(4) DEFAULT '1' COMMENT '是否可自动升级 0：否  1： 是。 开启后则达到设置条件自动升级为该级别',
  `show_upgrade_condition` int(4) DEFAULT '0' COMMENT '自动升级条件显示。0：隐藏  1：显示。 控制前端是否显示升级条件',
  `reward_integral` int(4) DEFAULT '0' COMMENT '升到此等级，奖励积分',
  `reward_balance` int(4) DEFAULT '0' COMMENT '升到此等级，奖励余额',
  `reward_commission` int(4) DEFAULT '0' COMMENT '升到此等级，奖励佣金',
  `reward_recommend` int(4) DEFAULT '0' COMMENT '升到此等级，给推荐人奖励佣金',
  `distribute_enable` int(4) DEFAULT '0' COMMENT '分销权限之是否开启权限 0:否 1：是',
  `distribute_level` int(4) DEFAULT '0' COMMENT '分销权限之分销层级。1：一级分销，2：二级分销:3：三级分销',
  `distribute_type` int(4) DEFAULT '0' COMMENT '分销权限之提成方式 0：百分比 1：固定金额。设置固定金额时按单返佣金,和购买数量无关',
  `distribute_reward_commission_first` int(4) DEFAULT '0' COMMENT '分销权限之一级提成金额',
  `distribute_reward_commission_second` int(4) DEFAULT '0' COMMENT '分销权限之二级提成金额',
  `distribute_reward_commission_third` int(4) DEFAULT '0' COMMENT '分销权限之三级提成金额',
  `distribute_reward_commission_continuous` int(4) DEFAULT '0' COMMENT '分销权限之持续推荐奖励',
  `distribute_reward_integral_first` int(4) DEFAULT '0' COMMENT '分销权限之一级(积分)',
  `distribute_reward_integral_second` int(4) DEFAULT '0' COMMENT '分销权限之二级(积分)',
  `distribute_reward_integral_third` int(4) DEFAULT '0' COMMENT '分销权限之三级(积分)',
  `distribute_reward_integral_max` int(4) DEFAULT '0' COMMENT '分销权限之最高限制(积分)',
  `distribute_reward_rule` int(4) DEFAULT '0' COMMENT '分销权限之推荐规则 0:初次进入即绑定推荐关系 1:有推荐人时绑定推荐关系 2:不绑定推荐关系  3:首次消费后绑定推荐关系。初次进入即绑定推荐关系：只有没有进入过平台的新会员卡才能被推荐，并且初次进入就确定了推荐人，终身绑定，不会再被其他人推荐；\r\n有推荐人时绑定推荐关系：没有推荐人时可以被推荐，一旦有了推荐人，该会员卡的推荐人就确定了，不会再被其他人推荐；\r\n不绑定推荐关系：即使该会员卡有推荐人，当被另一个人推荐时，TA的推荐人就会变成后来推荐TA的人。\r\n首次消费后绑定推荐关系：即会员卡在未消费前，当被另一个人推荐时，TA的推荐人就会变成后来推荐TA的人。 ',
  `distribute_self` int(4) DEFAULT '0' COMMENT '分销权限之自己是否拿一级提成. 0:否 1：是。 开启则表示一级为自己，即自己购买商品自己拿一级佣金',
  `distribute_team_permission` varchar(255) DEFAULT '' COMMENT '分销权限之我的团队权限。 1:查看下级手机号， 2:给下级转余额  3:给下级转积分',
  `team_bonus_level` int(4) DEFAULT '0' COMMENT '团队分红之分红级数',
  `team_bonus_ratio` int(4) DEFAULT '0' COMMENT '团队分红之分红比例(%)',
  `team_bonus_amount` int(4) DEFAULT '0' COMMENT '团队分红之每单分红金额',
  `team_bonus_only_recent_parent` int(4) DEFAULT '0' COMMENT '团队分红之是否只给最近的上级分红',
  `team_bonus_include_self` int(4) DEFAULT '0' COMMENT '团队分红之是否包含自己',
  `shareholder_bonus_ratio` int(4) DEFAULT '0' COMMENT '股东分红之分红比例(%)。用于合伙人或股东分红，设置分红比例后该等级的所有人平均分摊所有商城订单的分红提成比例',
  `area_agent_close` int(4) DEFAULT '1' COMMENT '区域代理之关闭',
  `area_agent_province` int(4) DEFAULT '0' COMMENT '区域代理之省级',
  `area_agent_city` int(4) DEFAULT '0' COMMENT '区域代理之市级',
  `area_agent_district` int(4) DEFAULT '0' COMMENT '区域代理之区级',
  `area_agent_ratio` int(4) DEFAULT '0' COMMENT '区域代理之分红比例(%)',
  `area_agent_limit` int(4) DEFAULT '0' COMMENT '区域代理之人数限制',
  `valid_days` int(4) DEFAULT '0' COMMENT '等级有效期。升级成为该等级后多少天自动变回默认等级，0表示长期',
  `privilege` mediumtext COMMENT '特权说明',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员卡表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_member_card_apply_log`
--

CREATE TABLE `dxch_member_card_apply_log` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `member_card_id` int(4) NOT NULL COMMENT '会员卡ID',
  `user_id` int(4) NOT NULL COMMENT '用户ID',
  `recommend_user_id` int(4) DEFAULT '0' COMMENT '推荐人',
  `level` int(4) DEFAULT '0' COMMENT '申请等级',
  `application` varchar(255) NOT NULL COMMENT '申请资料',
  `amount` int(4) DEFAULT '0' COMMENT '金额',
  `status` int(4) DEFAULT '0' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='升级申请记录表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_member_card_apply_setting`
--

CREATE TABLE `dxch_member_card_apply_setting` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `member_card_id` int(4) NOT NULL COMMENT '会员卡ID',
  `user_id` int(4) NOT NULL COMMENT '用户ID',
  `sort` int(4) DEFAULT '0' COMMENT '排序',
  `name` varchar(20) NOT NULL COMMENT '字段名称',
  `type` int(4) DEFAULT '1' COMMENT '组件类型 (1:单行输入 2:多行输入 3:单项选择 4：多项选择 5：普通选择 6：时间选择 7：日期选择 8：省市区选择 9：上传图片)',
  `param_json` text COMMENT '组件参数',
  `value` varchar(255) NOT NULL COMMENT '值',
  `required` int(4) DEFAULT '1' COMMENT '是否必填 1：是 0：否',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员卡申请资料表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_member_card_order`
--

CREATE TABLE `dxch_member_card_order` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `transaction_id` varchar(50) DEFAULT '' COMMENT '微信交易单号',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `card_id` int(4) DEFAULT '0' COMMENT 'card_id',
  `price` int(4) DEFAULT '0' COMMENT '价格',
  `num` int(4) DEFAULT '1' COMMENT '数量',
  `order_status` int(4) DEFAULT '0' COMMENT '订单状态。0:默认  1：已取消 2：已过期',
  `pay_status` int(4) DEFAULT '0' COMMENT '付款状态 0:未支付 1:已支付 2:申请退款 3：已退款 ',
  `pay_type` int(4) DEFAULT '0' COMMENT '支付方式 0:小程序支付',
  `pay_at` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `issue_invoice` int(4) DEFAULT '0' COMMENT '是否已开发票 0:否 1:是',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员卡订单表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_member_upgrade_conditions`
--

CREATE TABLE `dxch_member_upgrade_conditions` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `member_card_id` int(4) NOT NULL COMMENT '会员卡ID',
  `type` int(4) DEFAULT '1' COMMENT '0：申请条件 1：升级条件',
  `logic_type` int(4) DEFAULT '0' COMMENT '逻辑类型 0:且 1:或',
  `condition_source_type` int(4) DEFAULT '0' COMMENT '升级条件的来源或触发者类型。 1:自购 2：团队  3:下级(一级，二级) ',
  `condition_category` int(4) DEFAULT '0' COMMENT '升级条件的类别或性质。0:充值 1:分销订单 2：非分销订单 3：商品 4:用户(分销商) ',
  `threshold_type` int(4) DEFAULT '1' COMMENT '门槛值类型 1: 金额 2:数量',
  `threshold` int(4) DEFAULT '0' COMMENT '门槛值',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员卡升级条件表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_mem_sku`
--

CREATE TABLE `dxch_mem_sku` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `spu_id` varchar(255) DEFAULT '' COMMENT '产品ID',
  `sku_id` varchar(255) DEFAULT '' COMMENT 'skuID',
  `card_id` int(4) DEFAULT '0' COMMENT 'card_id',
  `tag_id` int(4) DEFAULT '0' COMMENT 'tag_id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员商品表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_num_unit`
--

CREATE TABLE `dxch_num_unit` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '标题',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='sku数量单位表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_order`
--

CREATE TABLE `dxch_order` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `transaction_id` varchar(50) DEFAULT '' COMMENT '微信交易单号',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `old_price` int(4) DEFAULT '0' COMMENT '原价',
  `price` int(4) DEFAULT '0' COMMENT '价格',
  `num` int(4) DEFAULT '0' COMMENT '数量',
  `num_unit` int(4) DEFAULT '0' COMMENT '单位',
  `main_img` varchar(255) NOT NULL COMMENT '主图',
  `brand_id` int(4) DEFAULT '0' COMMENT '所属品牌ID',
  `cat_id` int(4) DEFAULT '0' COMMENT '分类ID',
  `sub_cat_id` int(4) DEFAULT '0' COMMENT '子分类ID',
  `attr_id` varchar(255) DEFAULT '' COMMENT '属性ID',
  `tag_id` varchar(255) DEFAULT '' COMMENT '标签ID',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '详情页',
  `is_new` int(4) DEFAULT '0' COMMENT '是否新品',
  `spu_id` int(4) DEFAULT '0' COMMENT 'spu_id',
  `sku_id` int(4) DEFAULT '0' COMMENT 'skuID',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `mem_id` int(4) DEFAULT '0' COMMENT 'mem_id',
  `act_id` int(4) DEFAULT '0' COMMENT '活动ID',
  `invite_id` int(4) DEFAULT '0' COMMENT '推荐ID',
  `addr_id` int(4) DEFAULT '0' COMMENT '地址ID',
  `traveler_id` int(4) DEFAULT '0' COMMENT '出行人ID',
  `order_status` int(4) DEFAULT '0' COMMENT '订单状态。0:默认  1：已取消 2：已过期',
  `pay_status` int(4) DEFAULT '0' COMMENT '付款状态 0:未支付 1:已支付 2:申请退款 3：已退款 ',
  `express_status` int(4) DEFAULT '0' COMMENT '物流状态 0：默认 1：配送中 2：已完成',
  `evaluate_status` int(4) DEFAULT '0' COMMENT '评级状态 0：默认 1：已评价',
  `point_status` int(4) DEFAULT '1' COMMENT '端可见状态 1：可见 0：用户不可见',
  `pay_type` int(4) DEFAULT '0' COMMENT '支付方式 0:小程序支付',
  `pay_at` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `express_type` int(4) DEFAULT '0' COMMENT '配送方式 0:立即送出',
  `issue_invoice` int(4) DEFAULT '0' COMMENT '是否已开发票 0:否 1:是',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品订单主表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_order_refund`
--

CREATE TABLE `dxch_order_refund` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `transaction_id` varchar(50) DEFAULT '' COMMENT '微信交易单号',
  `order_id` int(4) DEFAULT '0' COMMENT '订单ID',
  `order_no` varchar(20) NOT NULL COMMENT '订单号',
  `name` varchar(20) DEFAULT '' COMMENT '名称',
  `title` varchar(20) DEFAULT '' COMMENT '标题',
  `old_price` int(4) DEFAULT '0' COMMENT '原价',
  `price` int(4) DEFAULT '0' COMMENT '价格',
  `num` int(4) DEFAULT '0' COMMENT '数量',
  `num_unit` int(4) DEFAULT '0' COMMENT '单位',
  `main_img` varchar(255) DEFAULT '' COMMENT '主图',
  `brand_id` int(4) DEFAULT '0' COMMENT '所属品牌ID',
  `cat_id` int(4) DEFAULT '0' COMMENT '分类ID',
  `sub_cat_id` int(4) DEFAULT '0' COMMENT '子分类ID',
  `attr_id` varchar(255) DEFAULT '' COMMENT '属性ID',
  `tag_id` varchar(255) DEFAULT '' COMMENT '标签ID',
  `content` varchar(255) DEFAULT '' COMMENT '详情页',
  `is_new` int(4) DEFAULT '0' COMMENT '是否新品',
  `spu_id` int(4) DEFAULT '0' COMMENT 'spu_id',
  `sku_id` int(4) DEFAULT '0' COMMENT 'skuID',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `mem_id` int(4) DEFAULT '0' COMMENT 'mem_id',
  `addr_id` int(4) DEFAULT '0' COMMENT '地址ID',
  `traveler_id` int(4) DEFAULT '0' COMMENT '出行人ID',
  `act_id` varchar(255) DEFAULT '' COMMENT '活动IDs',
  `type` int(4) DEFAULT '0' COMMENT '0:退款 1:退货退款',
  `pay_at` timestamp NULL DEFAULT NULL COMMENT '退款时间',
  `pay_status` int(4) DEFAULT '0' COMMENT '付款状态 0:未支付 1:已支付 2:申请退款 3：已退款 ',
  `admin_id` int(4) DEFAULT '0' COMMENT '操作员ID',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单退款表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_param`
--

CREATE TABLE `dxch_param` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(20) NOT NULL COMMENT '商品参数名称',
  `cat_ids` varchar(255) DEFAULT '' COMMENT '适用分类ID',
  `type` int(4) DEFAULT '0' COMMENT '参数类型 0:  1:目的地',
  `value_type` int(4) DEFAULT '0' COMMENT '参数(值)类型 0:文本  1:单选项  2:多项选择',
  `content` varchar(255) DEFAULT '' COMMENT '描述',
  `is_need` int(4) DEFAULT '0' COMMENT '是否必填',
  `sort` int(4) DEFAULT '0' COMMENT '序号',
  `status` int(4) DEFAULT '1' COMMENT '状态 1:开启 0:关闭',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品参数表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_param_value`
--

CREATE TABLE `dxch_param_value` (
  `id` int(11) NOT NULL COMMENT '商品参数值ID',
  `fid` int(4) DEFAULT '0' COMMENT '父级ID',
  `param_id` int(11) NOT NULL COMMENT '商品参数ID',
  `param_value` varchar(255) DEFAULT '' COMMENT '商品参数值',
  `main_img` varchar(255) DEFAULT '' COMMENT '封面图(非必填)',
  `content` varchar(255) DEFAULT '' COMMENT '描述',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品参数值表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_product`
--

CREATE TABLE `dxch_product` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `name` varchar(255) NOT NULL COMMENT '产品名',
  `title` varchar(255) NOT NULL COMMENT '产品标题',
  `main_img` varchar(255) NOT NULL COMMENT '产品主图',
  `sub_img` varchar(255) DEFAULT '' COMMENT '产品子图',
  `brand_id` int(4) DEFAULT '0' COMMENT '所属品牌ID',
  `cat_id` int(4) DEFAULT '0' COMMENT '分类ID',
  `sub_cat_id` int(4) DEFAULT '0' COMMENT '子分类ID',
  `dest_id` varchar(255) DEFAULT '' COMMENT '销售目的地ID',
  `attr_id` varchar(255) DEFAULT '' COMMENT '属性ID',
  `param_id` varchar(255) DEFAULT '' COMMENT '参数ID',
  `group_id` varchar(255) DEFAULT '' COMMENT '分组ID',
  `content` mediumtext COMMENT '产品详情页',
  `is_new` int(4) DEFAULT '0' COMMENT '是否新品',
  `sort` int(4) DEFAULT '1' COMMENT '排序',
  `score` int(4) DEFAULT '0' COMMENT '好评排序',
  `sale` int(4) DEFAULT '0' COMMENT '真实销量',
  `virtual_sale` int(4) DEFAULT '0' COMMENT '虚拟销量',
  `distribute_set` int(4) DEFAULT '1' COMMENT '分销设置 0:不参与分销 1:按照会员卡等级',
  `commision_set` int(4) DEFAULT '1' COMMENT '分红设置 0:不参与 1:参与',
  `team_bonus_set` int(4) DEFAULT '1' COMMENT '团队分红 0:不参与分红 1:按照会员卡等级',
  `shareholder_bonus_set` int(4) DEFAULT '1' COMMENT '股东分红 0:不参与分红 1:按照会员卡等级',
  `area_agent_set` int(4) DEFAULT '1' COMMENT '区域代理分红 0:不参与分红 1:按照会员卡等级',
  `type` int(4) DEFAULT '0' COMMENT '产品类型 0:普通商品 1:普通文章',
  `stock` int(4) DEFAULT '0' COMMENT '库存',
  `status` int(4) DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品主表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_recharge_records`
--

CREATE TABLE `dxch_recharge_records` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号/付款单号',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `card_id` int(4) DEFAULT '0' COMMENT 'card_id',
  `recharge_balance` int(4) DEFAULT '0' COMMENT '充值金额',
  `pay_type` int(4) DEFAULT '0' COMMENT '支付方式',
  `pay_at` timestamp NULL DEFAULT NULL COMMENT '付款时间',
  `status` int(4) DEFAULT '0' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='充值记录表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_reward`
--

CREATE TABLE `dxch_reward` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `can_withdraw` int(4) DEFAULT '0' COMMENT '可提现佣金',
  `withdraw` int(4) DEFAULT '0' COMMENT '已提现佣金',
  `on_way` int(4) DEFAULT '0' COMMENT '在路上',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='佣金表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_service`
--

CREATE TABLE `dxch_service` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '标题',
  `type` int(4) DEFAULT '0' COMMENT '类型',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='服务协议表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_sku`
--

CREATE TABLE `dxch_sku` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '产品名',
  `parent_id` int(4) DEFAULT '0' COMMENT '父ID',
  `spu_id` int(4) DEFAULT '0' COMMENT 'spuID',
  `sort` int(4) DEFAULT '1' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品规格表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_sku_price`
--

CREATE TABLE `dxch_sku_price` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `spu_id` int(4) DEFAULT '0' COMMENT '所属spu',
  `sku_ids` varchar(255) DEFAULT '' COMMENT '规格',
  `sku_text` varchar(255) DEFAULT '' COMMENT '规格中文',
  `main_img` varchar(255) DEFAULT '' COMMENT '产品图',
  `price` int(4) DEFAULT '0' COMMENT '价格',
  `old_price` int(4) DEFAULT '0' COMMENT '原价',
  `stock` int(4) DEFAULT NULL,
  `status` int(4) DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品规格价格表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_sub_cart`
--

CREATE TABLE `dxch_sub_cart` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `cart_id` int(4) DEFAULT '0' COMMENT 'cart_id',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `title` varchar(20) NOT NULL COMMENT '标题',
  `old_price` int(4) DEFAULT '0' COMMENT '原价',
  `price` int(4) DEFAULT '0' COMMENT '价格',
  `main_img` varchar(255) NOT NULL COMMENT '主图',
  `attr_id` varchar(255) DEFAULT '' COMMENT '属性ID',
  `tag_id` varchar(255) DEFAULT '' COMMENT '标签ID',
  `is_new` int(4) DEFAULT '0' COMMENT '是否新品',
  `num` int(4) DEFAULT '0' COMMENT '数量',
  `num_unit` int(4) DEFAULT '0' COMMENT '单位',
  `spu_id` int(4) DEFAULT '0' COMMENT 'spu_id',
  `sku_id` int(4) DEFAULT '0' COMMENT 'skuID',
  `act_id` varchar(255) DEFAULT '' COMMENT '活动IDs',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车明细表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_sub_finance`
--

CREATE TABLE `dxch_sub_finance` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `finance_id` int(4) DEFAULT '0' COMMENT '账户ID',
  `type` int(4) DEFAULT '0' COMMENT '消费类型 0：下单支付 1：开通会员  佣金 ',
  `access` int(4) DEFAULT '0' COMMENT '0：出账 1：进账 ',
  `title` varchar(20) NOT NULL COMMENT '标题',
  `note` varchar(20) NOT NULL COMMENT '备注',
  `price` int(4) DEFAULT '0' COMMENT '金额',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='财务流水账表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_sub_order`
--

CREATE TABLE `dxch_sub_order` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `order_id` int(4) DEFAULT '0' COMMENT '订单ID',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `old_price` int(4) DEFAULT '0' COMMENT '原价',
  `price` int(4) DEFAULT '0' COMMENT '价格',
  `num` int(4) DEFAULT '0' COMMENT '数量',
  `num_unit` int(4) DEFAULT '0' COMMENT '单位',
  `main_img` varchar(255) NOT NULL COMMENT '主图',
  `brand_id` int(4) DEFAULT '0' COMMENT '所属品牌ID',
  `cat_id` int(4) DEFAULT '0' COMMENT '分类ID',
  `sub_cat_id` int(4) DEFAULT '0' COMMENT '子分类ID',
  `attr_id` varchar(255) DEFAULT '' COMMENT '属性ID',
  `tag_id` varchar(255) DEFAULT '' COMMENT '标签ID',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '详情页',
  `is_new` int(4) DEFAULT '0' COMMENT '是否新品',
  `spu_id` int(4) DEFAULT '0' COMMENT 'spu_id',
  `sku_id` int(4) DEFAULT '0' COMMENT 'skuID',
  `user_id` int(4) DEFAULT '0' COMMENT 'user_id',
  `mem_id` int(4) DEFAULT '0' COMMENT 'mem_id',
  `addr_id` int(4) DEFAULT '0' COMMENT '地址ID',
  `act_id` varchar(255) DEFAULT '' COMMENT '活动IDs',
  `traveler_date` timestamp NULL DEFAULT NULL COMMENT '出行日期',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品子订单表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_system_config`
--

CREATE TABLE `dxch_system_config` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(50) DEFAULT '' COMMENT '名称',
  `page` varchar(50) DEFAULT '' COMMENT '所属页面',
  `endpoint` int(4) DEFAULT '0' COMMENT '端 0:小程序',
  `key` varchar(50) DEFAULT '' COMMENT 'key',
  `value` json DEFAULT NULL COMMENT 'value',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_system_log`
--

CREATE TABLE `dxch_system_log` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(50) DEFAULT '' COMMENT '名称',
  `page` varchar(50) DEFAULT '' COMMENT '所属页面',
  `endpoint` int(4) DEFAULT '0' COMMENT '端 0:默认 1:小程序 2:PC ',
  `type` int(4) DEFAULT '0' COMMENT '日志类型 0:默认 1:登录',
  `type_text` varchar(50) DEFAULT '' COMMENT '日志类型文本 ',
  `user_id` int(4) DEFAULT '0' COMMENT '操作员ID',
  `note` varchar(255) DEFAULT '' COMMENT '注释',
  `key` varchar(50) DEFAULT '' COMMENT 'key',
  `value` json DEFAULT NULL COMMENT 'value',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统日志表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_tag`
--

CREATE TABLE `dxch_tag` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '标题',
  `type` int(4) DEFAULT '0' COMMENT '类型',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品标签表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_travel`
--

CREATE TABLE `dxch_travel` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `user_id` int(4) NOT NULL COMMENT '用户ID',
  `surname` varchar(20) NOT NULL COMMENT '姓',
  `name` varchar(20) NOT NULL COMMENT '名',
  `birthday` timestamp NULL DEFAULT NULL COMMENT '出生日期',
  `sex` int(4) DEFAULT '0' COMMENT '性别 1：男 0：女',
  `country_id` int(4) DEFAULT '0' COMMENT '国家ID',
  `passport_no` varchar(20) NOT NULL COMMENT '护照号码',
  `passport_expire_date` timestamp NULL DEFAULT NULL COMMENT '护照有效期',
  `passport_photo` varchar(255) NOT NULL DEFAULT '' COMMENT '护照照片',
  `id_photo` varchar(255) NOT NULL DEFAULT '' COMMENT '证件照片',
  `visa_photo` varchar(255) NOT NULL DEFAULT '' COMMENT '签证照片',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='出行人表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_user`
--

CREATE TABLE `dxch_user` (
  `id` int(11) NOT NULL COMMENT '用户ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `nickname` varchar(255) DEFAULT NULL COMMENT '昵称',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间',
  `openid` varchar(50) NOT NULL DEFAULT '' COMMENT '授权ID',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `phone` char(15) DEFAULT NULL COMMENT '手机',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT 'email',
  `api_token` varchar(255) DEFAULT '' COMMENT 'token',
  `remember_token` varchar(255) DEFAULT '' COMMENT 'remember_token'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户总表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_user_addr`
--

CREATE TABLE `dxch_user_addr` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `user_id` int(4) DEFAULT '0' COMMENT '前台用户ID',
  `name` varchar(20) NOT NULL COMMENT '用户名',
  `phone` char(15) DEFAULT NULL COMMENT '手机',
  `province_id` int(4) DEFAULT '0' COMMENT '省ID',
  `city_id` int(4) DEFAULT '0' COMMENT '市级ID',
  `region_id` int(4) DEFAULT '0' COMMENT '地区级ID',
  `content` varchar(10) DEFAULT NULL COMMENT '详细地址',
  `is_default` int(4) DEFAULT '0' COMMENT '是否默认地址',
  `weixin` varchar(50) DEFAULT '' COMMENT '微信号',
  `note` varchar(255) DEFAULT '' COMMENT '备注',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='地址表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_volume_unit`
--

CREATE TABLE `dxch_volume_unit` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(20) NOT NULL COMMENT '名称',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '标题',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='sku容量单位表';

-- --------------------------------------------------------

--
-- 表的结构 `dxch_withdraw`
--

CREATE TABLE `dxch_withdraw` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `trade_no` varchar(20) NOT NULL COMMENT '流水号',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `money` int(4) DEFAULT '0' COMMENT '金额',
  `status` int(4) DEFAULT '0' COMMENT ' 0:审核中 1:审核通过 2:审核失败',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提现记录';

--
-- 转储表的索引
--

--
-- 表的索引 `dxch_act`
--
ALTER TABLE `dxch_act`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`type`) USING BTREE;

--
-- 表的索引 `dxch_act_rule`
--
ALTER TABLE `dxch_act_rule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`act_id`,`num`,`type`) USING BTREE;

--
-- 表的索引 `dxch_act_spu`
--
ALTER TABLE `dxch_act_spu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`act_id`,`is_all`,`brand_id`,`cat_id`,`spu_id`) USING BTREE;

--
-- 表的索引 `dxch_act_user`
--
ALTER TABLE `dxch_act_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`act_id`,`is_all`,`level`,`user_id`) USING BTREE;

--
-- 表的索引 `dxch_area`
--
ALTER TABLE `dxch_area`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `dxch_article`
--
ALTER TABLE `dxch_article`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`name`,`sort`,`cat_id`) USING BTREE,
  ADD KEY `index_2` (`is_new`,`type`) USING BTREE;

--
-- 表的索引 `dxch_attr`
--
ALTER TABLE `dxch_attr`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dxch_balance_details`
--
ALTER TABLE `dxch_balance_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`user_id`,`pay_type`) USING BTREE;

--
-- 表的索引 `dxch_balance_withdraw`
--
ALTER TABLE `dxch_balance_withdraw`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`user_id`,`withdraw_type`) USING BTREE;

--
-- 表的索引 `dxch_bonus_records`
--
ALTER TABLE `dxch_bonus_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`user_id`,`card_id`) USING BTREE;

--
-- 表的索引 `dxch_brand`
--
ALTER TABLE `dxch_brand`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dxch_cart`
--
ALTER TABLE `dxch_cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`user_id`,`mem_id`) USING BTREE;

--
-- 表的索引 `dxch_cat`
--
ALTER TABLE `dxch_cat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`fid`,`cid`,`level`) USING BTREE;

--
-- 表的索引 `dxch_cities`
--
ALTER TABLE `dxch_cities`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `cities_state_id_index` (`state_id`) USING BTREE,
  ADD KEY `cities_code_index` (`code_full`) USING BTREE;

--
-- 表的索引 `dxch_commission_agent`
--
ALTER TABLE `dxch_commission_agent`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`user_id`,`level`) USING BTREE;

--
-- 表的索引 `dxch_commission_details`
--
ALTER TABLE `dxch_commission_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`user_id`,`pay_type`) USING BTREE;

--
-- 表的索引 `dxch_commission_records`
--
ALTER TABLE `dxch_commission_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`user_id`,`commission_source`) USING BTREE;

--
-- 表的索引 `dxch_commission_withdraw`
--
ALTER TABLE `dxch_commission_withdraw`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`user_id`,`withdraw_type`) USING BTREE;

--
-- 表的索引 `dxch_consumption_details`
--
ALTER TABLE `dxch_consumption_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`user_id`,`pay_type`) USING BTREE;

--
-- 表的索引 `dxch_continents`
--
ALTER TABLE `dxch_continents`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- 表的索引 `dxch_countries`
--
ALTER TABLE `dxch_countries`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `countries_code_index` (`code`) USING BTREE;

--
-- 表的索引 `dxch_custom_form`
--
ALTER TABLE `dxch_custom_form`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`type`,`is_active`) USING BTREE;

--
-- 表的索引 `dxch_dest`
--
ALTER TABLE `dxch_dest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`name`,`dest_id`) USING BTREE;

--
-- 表的索引 `dxch_dis`
--
ALTER TABLE `dxch_dis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`fid`,`cid`,`level`) USING BTREE;

--
-- 表的索引 `dxch_dis_conditions`
--
ALTER TABLE `dxch_dis_conditions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`operator`) USING BTREE;

--
-- 表的索引 `dxch_dis_rule`
--
ALTER TABLE `dxch_dis_rule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`num`,`unit`,`return_num`,`return_unit`,`dis_id`) USING BTREE;

--
-- 表的索引 `dxch_dis_rules`
--
ALTER TABLE `dxch_dis_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`type`) USING BTREE;

--
-- 表的索引 `dxch_dis_rule_conditions`
--
ALTER TABLE `dxch_dis_rule_conditions`
  ADD PRIMARY KEY (`rule_id`,`condition_id`),
  ADD KEY `condition_id` (`condition_id`);

--
-- 表的索引 `dxch_dis_rule_hierarchy`
--
ALTER TABLE `dxch_dis_rule_hierarchy`
  ADD PRIMARY KEY (`parent_rule_id`,`child_rule_id`),
  ADD KEY `child_rule_id` (`child_rule_id`);

--
-- 表的索引 `dxch_end_user`
--
ALTER TABLE `dxch_end_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`username`,`nickname`,`is_new`,`phone`) USING BTREE;

--
-- 表的索引 `dxch_evaluate`
--
ALTER TABLE `dxch_evaluate`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`spu_id`,`user_id`) USING BTREE;

--
-- 表的索引 `dxch_finance`
--
ALTER TABLE `dxch_finance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`user_id`,`status`) USING BTREE;

--
-- 表的索引 `dxch_font_user`
--
ALTER TABLE `dxch_font_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `openid` (`openid`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `phone_2` (`phone`),
  ADD UNIQUE KEY `wechat_phone` (`wechat_phone`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`username`,`nickname`,`is_new`,`phone`) USING BTREE;

--
-- 表的索引 `dxch_font_virtual_user`
--
ALTER TABLE `dxch_font_virtual_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`username`,`level`,`phone`) USING BTREE;

--
-- 表的索引 `dxch_form_fields`
--
ALTER TABLE `dxch_form_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`form_id`,`type`) USING BTREE;

--
-- 表的索引 `dxch_group`
--
ALTER TABLE `dxch_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`name`,`sort`,`status`) USING BTREE;

--
-- 表的索引 `dxch_insured_person`
--
ALTER TABLE `dxch_insured_person`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dxch_invoice`
--
ALTER TABLE `dxch_invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`user_id`,`invoice_title`) USING BTREE;

--
-- 表的索引 `dxch_member_card`
--
ALTER TABLE `dxch_member_card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_name_level` (`name`,`sort`) USING BTREE;

--
-- 表的索引 `dxch_member_card_apply_log`
--
ALTER TABLE `dxch_member_card_apply_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`member_card_id`,`user_id`) USING BTREE;

--
-- 表的索引 `dxch_member_card_apply_setting`
--
ALTER TABLE `dxch_member_card_apply_setting`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`member_card_id`,`user_id`) USING BTREE;

--
-- 表的索引 `dxch_member_card_order`
--
ALTER TABLE `dxch_member_card_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_trade_no` (`trade_no`,`user_id`) USING BTREE;

--
-- 表的索引 `dxch_member_upgrade_conditions`
--
ALTER TABLE `dxch_member_upgrade_conditions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_name_level` (`member_card_id`,`logic_type`) USING BTREE;

--
-- 表的索引 `dxch_mem_sku`
--
ALTER TABLE `dxch_mem_sku`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`spu_id`,`sku_id`,`card_id`,`tag_id`) USING BTREE;

--
-- 表的索引 `dxch_num_unit`
--
ALTER TABLE `dxch_num_unit`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dxch_order`
--
ALTER TABLE `dxch_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`spu_id`,`sku_id`,`user_id`,`mem_id`) USING BTREE,
  ADD KEY `index_2` (`order_status`,`pay_status`,`express_status`,`evaluate_status`) USING BTREE;

--
-- 表的索引 `dxch_order_refund`
--
ALTER TABLE `dxch_order_refund`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`spu_id`,`sku_id`,`user_id`,`mem_id`) USING BTREE;

--
-- 表的索引 `dxch_param`
--
ALTER TABLE `dxch_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`sort`,`status`) USING BTREE,
  ADD KEY `index_2` (`type`,`status`) USING BTREE;

--
-- 表的索引 `dxch_param_value`
--
ALTER TABLE `dxch_param_value`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`fid`,`param_id`) USING BTREE;

--
-- 表的索引 `dxch_product`
--
ALTER TABLE `dxch_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`name`,`brand_id`,`cat_id`) USING BTREE,
  ADD KEY `index_2` (`is_new`) USING BTREE;

--
-- 表的索引 `dxch_recharge_records`
--
ALTER TABLE `dxch_recharge_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`card_id`,`pay_type`) USING BTREE;

--
-- 表的索引 `dxch_reward`
--
ALTER TABLE `dxch_reward`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_trade_no` (`trade_no`,`user_id`) USING BTREE;

--
-- 表的索引 `dxch_service`
--
ALTER TABLE `dxch_service`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dxch_sku`
--
ALTER TABLE `dxch_sku`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`spu_id`,`parent_id`,`sort`) USING BTREE;

--
-- 表的索引 `dxch_sku_price`
--
ALTER TABLE `dxch_sku_price`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`spu_id`) USING BTREE,
  ADD KEY `index_2` (`status`) USING BTREE,
  ADD KEY `index_3` (`price`) USING BTREE;

--
-- 表的索引 `dxch_sub_cart`
--
ALTER TABLE `dxch_sub_cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`spu_id`,`sku_id`,`cart_id`) USING BTREE;

--
-- 表的索引 `dxch_sub_finance`
--
ALTER TABLE `dxch_sub_finance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`finance_id`,`type`,`access`) USING BTREE;

--
-- 表的索引 `dxch_sub_order`
--
ALTER TABLE `dxch_sub_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`spu_id`,`sku_id`,`user_id`,`mem_id`) USING BTREE;

--
-- 表的索引 `dxch_system_config`
--
ALTER TABLE `dxch_system_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`key`,`endpoint`) USING BTREE;

--
-- 表的索引 `dxch_system_log`
--
ALTER TABLE `dxch_system_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`key`,`endpoint`) USING BTREE;

--
-- 表的索引 `dxch_tag`
--
ALTER TABLE `dxch_tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_1` (`name`,`type`) USING BTREE;

--
-- 表的索引 `dxch_travel`
--
ALTER TABLE `dxch_travel`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dxch_user`
--
ALTER TABLE `dxch_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_name_phone` (`username`,`phone`) USING BTREE;

--
-- 表的索引 `dxch_user_addr`
--
ALTER TABLE `dxch_user_addr`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_0` (`trade_no`) USING BTREE,
  ADD KEY `index_1` (`name`,`is_default`) USING BTREE,
  ADD KEY `index_2` (`province_id`,`city_id`,`region_id`) USING BTREE;

--
-- 表的索引 `dxch_volume_unit`
--
ALTER TABLE `dxch_volume_unit`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `dxch_withdraw`
--
ALTER TABLE `dxch_withdraw`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_trade_no` (`trade_no`,`user_id`) USING BTREE;

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `dxch_act`
--
ALTER TABLE `dxch_act`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_act_rule`
--
ALTER TABLE `dxch_act_rule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_act_spu`
--
ALTER TABLE `dxch_act_spu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_act_user`
--
ALTER TABLE `dxch_act_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_area`
--
ALTER TABLE `dxch_area`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `dxch_article`
--
ALTER TABLE `dxch_article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_attr`
--
ALTER TABLE `dxch_attr`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_balance_details`
--
ALTER TABLE `dxch_balance_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_balance_withdraw`
--
ALTER TABLE `dxch_balance_withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_bonus_records`
--
ALTER TABLE `dxch_bonus_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_brand`
--
ALTER TABLE `dxch_brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_cart`
--
ALTER TABLE `dxch_cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_cat`
--
ALTER TABLE `dxch_cat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_cities`
--
ALTER TABLE `dxch_cities`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `dxch_commission_agent`
--
ALTER TABLE `dxch_commission_agent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_commission_details`
--
ALTER TABLE `dxch_commission_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_commission_records`
--
ALTER TABLE `dxch_commission_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_commission_withdraw`
--
ALTER TABLE `dxch_commission_withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_consumption_details`
--
ALTER TABLE `dxch_consumption_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_continents`
--
ALTER TABLE `dxch_continents`
  MODIFY `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id';

--
-- 使用表AUTO_INCREMENT `dxch_countries`
--
ALTER TABLE `dxch_countries`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `dxch_custom_form`
--
ALTER TABLE `dxch_custom_form`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_dest`
--
ALTER TABLE `dxch_dest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_dis`
--
ALTER TABLE `dxch_dis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_dis_conditions`
--
ALTER TABLE `dxch_dis_conditions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_dis_rule`
--
ALTER TABLE `dxch_dis_rule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_dis_rules`
--
ALTER TABLE `dxch_dis_rules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_end_user`
--
ALTER TABLE `dxch_end_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_evaluate`
--
ALTER TABLE `dxch_evaluate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_finance`
--
ALTER TABLE `dxch_finance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_font_user`
--
ALTER TABLE `dxch_font_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_font_virtual_user`
--
ALTER TABLE `dxch_font_virtual_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_form_fields`
--
ALTER TABLE `dxch_form_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_group`
--
ALTER TABLE `dxch_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_insured_person`
--
ALTER TABLE `dxch_insured_person`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_invoice`
--
ALTER TABLE `dxch_invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_member_card`
--
ALTER TABLE `dxch_member_card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_member_card_apply_log`
--
ALTER TABLE `dxch_member_card_apply_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_member_card_apply_setting`
--
ALTER TABLE `dxch_member_card_apply_setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_member_card_order`
--
ALTER TABLE `dxch_member_card_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_member_upgrade_conditions`
--
ALTER TABLE `dxch_member_upgrade_conditions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_mem_sku`
--
ALTER TABLE `dxch_mem_sku`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_num_unit`
--
ALTER TABLE `dxch_num_unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_order`
--
ALTER TABLE `dxch_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_order_refund`
--
ALTER TABLE `dxch_order_refund`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_param`
--
ALTER TABLE `dxch_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_param_value`
--
ALTER TABLE `dxch_param_value`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品参数值ID';

--
-- 使用表AUTO_INCREMENT `dxch_product`
--
ALTER TABLE `dxch_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_recharge_records`
--
ALTER TABLE `dxch_recharge_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_reward`
--
ALTER TABLE `dxch_reward`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_service`
--
ALTER TABLE `dxch_service`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_sku`
--
ALTER TABLE `dxch_sku`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_sku_price`
--
ALTER TABLE `dxch_sku_price`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_sub_cart`
--
ALTER TABLE `dxch_sub_cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_sub_finance`
--
ALTER TABLE `dxch_sub_finance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_sub_order`
--
ALTER TABLE `dxch_sub_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_system_config`
--
ALTER TABLE `dxch_system_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_system_log`
--
ALTER TABLE `dxch_system_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_tag`
--
ALTER TABLE `dxch_tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_travel`
--
ALTER TABLE `dxch_travel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_user`
--
ALTER TABLE `dxch_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID';

--
-- 使用表AUTO_INCREMENT `dxch_user_addr`
--
ALTER TABLE `dxch_user_addr`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_volume_unit`
--
ALTER TABLE `dxch_volume_unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 使用表AUTO_INCREMENT `dxch_withdraw`
--
ALTER TABLE `dxch_withdraw`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID';

--
-- 限制导出的表
--

--
-- 限制表 `dxch_dis_rule_conditions`
--
ALTER TABLE `dxch_dis_rule_conditions`
  ADD CONSTRAINT `dxch_dis_rule_conditions_ibfk_1` FOREIGN KEY (`rule_id`) REFERENCES `dxch_dis_rules` (`id`),
  ADD CONSTRAINT `dxch_dis_rule_conditions_ibfk_2` FOREIGN KEY (`condition_id`) REFERENCES `dxch_dis_conditions` (`id`);

--
-- 限制表 `dxch_dis_rule_hierarchy`
--
ALTER TABLE `dxch_dis_rule_hierarchy`
  ADD CONSTRAINT `dxch_dis_rule_hierarchy_ibfk_1` FOREIGN KEY (`parent_rule_id`) REFERENCES `dxch_dis_rules` (`id`),
  ADD CONSTRAINT `dxch_dis_rule_hierarchy_ibfk_2` FOREIGN KEY (`child_rule_id`) REFERENCES `dxch_dis_rules` (`id`);
COMMIT;


