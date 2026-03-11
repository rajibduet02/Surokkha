import { motion } from "motion/react";
import {
  Crown,
  Check,
  Shield,
  Zap,
  MapPin,
  Users,
  Bell,
  Phone,
  Clock,
  Star,
  ArrowLeft,
  X,
} from "lucide-react";
import { Link } from "react-router";
import { FloatingNav } from "../components/FloatingNav";

export function PremiumScreen() {
  const comparisonFeatures = [
    { feature: "Emergency SOS Button", free: true, premium: true },
    { feature: "Emergency Contacts", free: "3 contacts", premium: "Unlimited" },
    { feature: "Live Location Tracking", free: false, premium: true },
    { feature: "Safe Zones Alerts", free: "1 zone", premium: "Unlimited" },
    { feature: "999 Direct Hotline", free: false, premium: true },
    { feature: "AI Threat Detection", free: false, premium: true },
    { feature: "24/7 Priority Support", free: false, premium: true },
    { feature: "Journey Timer", free: false, premium: true },
  ];

  const plans = [
    {
      name: "Monthly",
      price: "৳199",
      period: "/month",
      popular: false,
      description: "Full protection, billed monthly",
    },
    {
      name: "Yearly",
      price: "৳1,499",
      period: "/year",
      popular: true,
      savings: "Save ৳889",
      description: "Best value, ৳125/month",
    },
    {
      name: "Family Plan",
      price: "৳249",
      period: "/month",
      popular: false,
      description: "Up to 5 family members",
      badge: "NEW",
    },
  ];

  return (
    <div className="min-h-screen bg-[#0A0A0F]">
      <div className="w-full max-w-[430px] mx-auto px-6 py-8 space-y-8 pb-32">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.3 }}
          className="flex items-center justify-between"
        >
          <Link to="/dashboard">
            <button className="w-10 h-10 bg-[#1A1A22] rounded-[12px] border border-[#2A2A32] hover:border-[#D4AF37]/30 transition-colors flex items-center justify-center">
              <ArrowLeft className="w-6 h-6 text-[#8A8A92]" />
            </button>
          </Link>
          <h2 className="text-white text-[22px] font-semibold">Premium</h2>
          <div className="w-10" />
        </motion.div>

        {/* Hero Section */}
        <motion.div
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.1 }}
          className="relative"
        >
          {/* Gold Glow Effect */}
          <div className="absolute inset-0 bg-gradient-to-br from-[#D4AF37]/30 to-[#F6D365]/30 rounded-[32px] blur-3xl" />
          
          <div className="relative bg-gradient-to-br from-[#1A1A22] to-[#2A2A32] p-8 rounded-[32px] border border-[#D4AF37]/30 text-center space-y-6">
            {/* Crown Icon */}
            <div className="inline-block">
              <motion.div
                animate={{
                  scale: [1, 1.05, 1],
                  rotate: [0, 5, -5, 0],
                }}
                transition={{ duration: 4, repeat: Infinity }}
                className="w-20 h-20 bg-gradient-to-br from-[#D4AF37] to-[#F6D365] rounded-[24px] flex items-center justify-center mx-auto shadow-2xl shadow-[#D4AF37]/50"
              >
                <Crown className="w-10 h-10 text-[#0A0A0F]" fill="#0A0A0F" />
              </motion.div>
            </div>

            {/* Headline */}
            <div>
              <h1 className="text-white text-3xl font-bold mb-3 leading-tight">
                Upgrade to Premium
                <br />
                <span className="text-[#D4AF37]">Protection</span>
              </h1>
              <p className="text-[#CFCFCF] text-sm">
                Ultimate safety with exclusive features and
                <br />
                24/7 priority emergency response
              </p>
            </div>

            {/* Trial Badge */}
            <motion.div
              animate={{
                scale: [1, 1.03, 1],
              }}
              transition={{ duration: 2, repeat: Infinity }}
              className="inline-flex items-center gap-2 bg-gradient-to-r from-[#D4AF37]/20 to-[#F6D365]/20 border border-[#D4AF37]/30 px-5 py-2.5 rounded-full"
            >
              <Clock className="w-4 h-4 text-[#D4AF37]" />
              <span className="text-[#D4AF37] text-sm font-semibold">
                15-Day Free Trial • 12 Days Left
              </span>
            </motion.div>
          </div>
        </motion.div>

        {/* Pricing Cards */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
          className="space-y-4"
        >
          <h3 className="text-white font-semibold text-lg px-2">
            Choose Your Plan
          </h3>

          {plans.map((plan, index) => (
            <motion.button
              key={plan.name}
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: 0.5 + index * 0.1 }}
              whileHover={{ scale: 1.01 }}
              whileTap={{ scale: 0.99 }}
              className={`w-full p-6 rounded-[24px] border transition-all relative overflow-hidden ${
                plan.popular
                  ? "bg-gradient-to-br from-[#D4AF37]/10 to-[#F6D365]/10 border-[#D4AF37]/50 shadow-lg shadow-[#D4AF37]/10"
                  : "bg-[#1A1A22]/60 backdrop-blur-xl border-[#D4AF37]/20"
              }`}
            >
              {/* Popular Badge */}
              {plan.popular && (
                <div className="absolute top-4 right-4 bg-gradient-to-r from-[#D4AF37] to-[#F6D365] px-3 py-1 rounded-full shadow-lg">
                  <span className="text-[#0A0A0F] text-xs font-bold">
                    MOST POPULAR
                  </span>
                </div>
              )}

              {/* New Badge */}
              {plan.badge && (
                <div className="absolute top-4 right-4 bg-gradient-to-r from-[#10B981] to-[#059669] px-3 py-1 rounded-full shadow-lg">
                  <span className="text-white text-xs font-bold">
                    {plan.badge}
                  </span>
                </div>
              )}

              <div className="flex items-center justify-between">
                <div className="text-left space-y-2 flex-1">
                  <h4 className="text-white font-bold text-xl">
                    {plan.name}
                  </h4>
                  <div className="flex items-baseline gap-1">
                    <span className="text-[#D4AF37] text-4xl font-bold">
                      {plan.price}
                    </span>
                    <span className="text-[#8A8A92] text-sm">
                      {plan.period}
                    </span>
                  </div>
                  <p className="text-[#8A8A92] text-xs">
                    {plan.description}
                  </p>
                  {plan.savings && (
                    <div className="inline-block bg-[#10B981]/10 border border-[#10B981]/30 px-3 py-1 rounded-full mt-2">
                      <span className="text-[#10B981] text-xs font-semibold">
                        {plan.savings}
                      </span>
                    </div>
                  )}
                </div>

                {/* Radio Button */}
                <div
                  className={`w-6 h-6 rounded-full border-2 flex items-center justify-center flex-shrink-0 ml-4 ${
                    plan.popular
                      ? "border-[#D4AF37] bg-[#D4AF37]"
                      : "border-[#8A8A92]"
                  }`}
                >
                  {plan.popular && (
                    <motion.div
                      initial={{ scale: 0 }}
                      animate={{ scale: 1 }}
                      className="w-3 h-3 bg-[#0A0A0F] rounded-full"
                    />
                  )}
                </div>
              </div>
            </motion.button>
          ))}
        </motion.div>

        {/* CTA Button */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.8 }}
          className="space-y-3"
        >
          <motion.button
            whileHover={{ scale: 1.02 }}
            whileTap={{ scale: 0.98 }}
            className="w-full bg-gradient-to-r from-[#D4AF37] to-[#F6D365] text-[#0A0A0F] font-bold text-lg py-5 rounded-[20px] shadow-2xl shadow-[#D4AF37]/30 relative overflow-hidden"
          >
            <motion.div
              animate={{
                x: ["-100%", "100%"],
              }}
              transition={{ duration: 2, repeat: Infinity, ease: "linear" }}
              className="absolute inset-0 bg-gradient-to-r from-transparent via-white/30 to-transparent"
            />
            <span className="relative z-10">Start Subscription</span>
          </motion.button>
          <p className="text-[#8A8A92] text-xs text-center">
            Cancel anytime • No commitment • 15-day money-back guarantee
          </p>
        </motion.div>

        {/* Trust Stats */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.9 }}
          className="flex items-center justify-between px-4 py-6 bg-[#1A1A22]/60 backdrop-blur-xl rounded-[20px] border border-[#D4AF37]/10"
        >
          <div className="text-center flex-1">
            <div className="text-[#D4AF37] text-2xl font-bold">50K+</div>
            <div className="text-[#8A8A92] text-xs mt-1">Protected</div>
          </div>
          <div className="w-px h-10 bg-[#D4AF37]/20" />
          <div className="text-center flex-1">
            <div className="text-[#D4AF37] text-2xl font-bold">99.9%</div>
            <div className="text-[#8A8A92] text-xs mt-1">Success Rate</div>
          </div>
          <div className="w-px h-10 bg-[#D4AF37]/20" />
          <div className="text-center flex-1">
            <div className="text-[#D4AF37] text-2xl font-bold">24/7</div>
            <div className="text-[#8A8A92] text-xs mt-1">Support</div>
          </div>
        </motion.div>

        {/* Background Glow Effects */}
        <div className="fixed top-20 left-0 w-64 h-64 bg-[#D4AF37]/5 rounded-full blur-3xl -z-10 pointer-events-none" />
        <div className="fixed bottom-40 right-0 w-64 h-64 bg-[#F6D365]/5 rounded-full blur-3xl -z-10 pointer-events-none" />
      </div>

      {/* Floating Navigation */}
      <FloatingNav />
    </div>
  );
}