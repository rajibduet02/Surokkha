import { motion } from "motion/react";
import {
  Phone,
  MapPin,
  PhoneCall,
  Moon,
  Users,
  Map,
  Activity,
  Crown,
  CheckCircle2,
  Settings,
  User,
  Baby,
} from "lucide-react";
import { Link } from "react-router";
import { useState } from "react";
import { FloatingNav } from "../components/FloatingNav";
import { useUser } from "../context/UserContext";

export function DashboardScreen() {
  const [isNightMode, setIsNightMode] = useState(false);
  const { userProfile, isChild, isWoman } = useUser();

  return (
    <div className="min-h-screen bg-[#0A0A0F]">
      <div className="w-full max-w-[430px] mx-auto px-6 py-8 space-y-8 pb-32">
        {/* Header - Top Section */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.3 }}
          className="space-y-4"
        >
          {/* Greeting & Settings */}
          <div className="flex items-start justify-between">
            <div>
              <h1 className="text-white text-[28px] font-bold leading-tight">Good Evening</h1>
              <div className="flex items-center gap-2 mt-1">
                <p className="text-[#CFCFCF] text-base">{userProfile?.name || "Sarah Rahman"}</p>
                {/* Profile Type Badge */}
                <Link to="/profile-type">
                  <div className={`flex items-center gap-1 px-2 py-0.5 rounded-full border ${
                    isChild 
                      ? "bg-[#F59E0B]/10 border-[#F59E0B]/30" 
                      : "bg-[#D4AF37]/10 border-[#D4AF37]/30"
                  }`}>
                    {isChild ? (
                      <Baby className="w-3 h-3 text-[#F59E0B]" />
                    ) : (
                      <User className="w-3 h-3 text-[#D4AF37]" />
                    )}
                    <span className={`text-[10px] font-medium ${
                      isChild ? "text-[#F59E0B]" : "text-[#D4AF37]"
                    }`}>
                      {isChild ? "Child" : "Woman"}
                    </span>
                  </div>
                </Link>
              </div>
            </div>
            <Link to="/profile">
              <button className="w-10 h-10 bg-[#1A1A22] rounded-[12px] border border-[#2A2A32] hover:border-[#D4AF37]/30 transition-colors flex items-center justify-center">
                <Settings className="w-6 h-6 text-[#8A8A92]" />
              </button>
            </Link>
          </div>

          {/* Status & Trial Badge */}
          <div className="flex items-center justify-between">
            {/* Protection Status */}
            <div className="flex items-center gap-2 bg-[#1A1A22] px-4 py-2.5 rounded-[16px] border border-[#10B981]/20">
              <div className="w-2 h-2 bg-[#10B981] rounded-full" />
              <span className="text-[#10B981] text-[13px] font-medium">
                Active Protection
              </span>
            </div>

            {/* Trial Badge */}
            <Link to="/premium">
              <div className="flex items-center gap-1.5 bg-[#D4AF37]/10 px-3 py-2 rounded-[12px] border border-[#D4AF37]/30">
                <Crown className="w-4 h-4 text-[#D4AF37]" fill="#D4AF37" />
                <span className="text-[#D4AF37] text-[13px] font-medium">
                  15 Days Trial
                </span>
              </div>
            </Link>
          </div>
        </motion.div>

        {/* Center - Large SOS Button */}
        <motion.div
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.1, duration: 0.3 }}
          className="flex items-center justify-center py-8"
        >
          <Link to="/emergency">
            <motion.div
              whileTap={{ scale: 0.95 }}
              transition={{ duration: 0.1 }}
              className="relative"
            >
              {/* Subtle Pulse Ring - Professional */}
              <motion.div
                animate={{
                  scale: [1, 1.2, 1],
                  opacity: [0.2, 0, 0.2],
                }}
                transition={{ duration: 3, repeat: Infinity, ease: "easeOut" }}
                className="absolute inset-0 border-2 border-[#D4AF37] rounded-full"
              />

              {/* SOS Button */}
              <motion.button
                className="relative w-[140px] h-[140px] bg-gradient-to-br from-[#D4AF37] to-[#F6D365] rounded-full flex items-center justify-center shadow-xl shadow-[#D4AF37]/20"
              >
                <span className="relative text-[#0A0A0F] text-[32px] font-bold tracking-wide">
                  SOS
                </span>
              </motion.button>
            </motion.div>
          </Link>
        </motion.div>

        {/* Quick Action Row */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="flex items-center justify-between px-4"
        >
          {/* Call 999 */}
          <motion.button
            whileTap={{ scale: 0.9 }}
            className="flex flex-col items-center gap-2"
          >
            <div className="w-16 h-16 bg-gradient-to-br from-[#EF4444] to-[#DC2626] rounded-full flex items-center justify-center shadow-lg shadow-[#EF4444]/30">
              <Phone className="w-7 h-7 text-white" />
            </div>
            <span className="text-[#CFCFCF] text-xs">Call 999</span>
          </motion.button>

          {/* Share Live */}
          <motion.button
            whileTap={{ scale: 0.9 }}
            className="flex flex-col items-center gap-2"
          >
            <div className="w-16 h-16 bg-gradient-to-br from-[#1A1A22] to-[#2A2A32] rounded-full border border-[#D4AF37]/30 flex items-center justify-center shadow-lg">
              <MapPin className="w-7 h-7 text-[#D4AF37]" />
            </div>
            <span className="text-[#CFCFCF] text-xs">Share Live</span>
          </motion.button>

          {/* Fake Call */}
          <motion.button
            whileTap={{ scale: 0.9 }}
            className="flex flex-col items-center gap-2"
          >
            <div className="w-16 h-16 bg-gradient-to-br from-[#1A1A22] to-[#2A2A32] rounded-full border border-[#F6D365]/30 flex items-center justify-center shadow-lg">
              <PhoneCall className="w-7 h-7 text-[#F6D365]" />
            </div>
            <span className="text-[#CFCFCF] text-xs">Fake Call</span>
          </motion.button>

          {/* Night Mode */}
          <motion.button
            whileTap={{ scale: 0.9 }}
            onClick={() => setIsNightMode(!isNightMode)}
            className="flex flex-col items-center gap-2"
          >
            <div className={`w-16 h-16 rounded-full flex items-center justify-center shadow-lg transition-all ${
              isNightMode
                ? "bg-gradient-to-br from-[#8B5CF6] to-[#6366F1] shadow-[#8B5CF6]/30"
                : "bg-gradient-to-br from-[#1A1A22] to-[#2A2A32] border border-[#8A8A92]/30"
            }`}>
              <Moon className={`w-7 h-7 ${isNightMode ? "text-white" : "text-[#8A8A92]"}`} />
            </div>
            <span className="text-[#CFCFCF] text-xs">Night Mode</span>
          </motion.button>
        </motion.div>

        {/* Bottom Section - Glass Cards */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="space-y-4 pb-8"
        >
          {/* Trusted Contacts Card */}
          <Link to="/contacts">
            <motion.div
              whileHover={{ scale: 1.01 }}
              whileTap={{ scale: 0.99 }}
              className="bg-[#1A1A22]/60 backdrop-blur-xl p-5 rounded-[20px] border border-[#D4AF37]/10 hover:border-[#D4AF37]/30 transition-all"
            >
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 bg-[#D4AF37]/10 rounded-[14px] flex items-center justify-center">
                    <Users className="w-6 h-6 text-[#D4AF37]" />
                  </div>
                  <div>
                    <h3 className="text-white font-semibold">Trusted Contacts</h3>
                    <p className="text-[#8A8A92] text-sm">5 contacts added</p>
                  </div>
                </div>
                <div className="text-[#D4AF37]">→</div>
              </div>
            </motion.div>
          </Link>

          {/* Safe Zones Card */}
          <Link to="/safe-zones">
            <motion.div
              whileHover={{ scale: 1.01 }}
              whileTap={{ scale: 0.99 }}
              className="bg-[#1A1A22]/60 backdrop-blur-xl p-5 rounded-[20px] border border-[#F6D365]/10 hover:border-[#F6D365]/30 transition-all"
            >
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 bg-[#F6D365]/10 rounded-[14px] flex items-center justify-center">
                    <Map className="w-6 h-6 text-[#F6D365]" />
                  </div>
                  <div>
                    <h3 className="text-white font-semibold">Safe Zones</h3>
                    <p className="text-[#8A8A92] text-sm">3 zones configured</p>
                  </div>
                </div>
                <div className="text-[#F6D365]">→</div>
              </div>
            </motion.div>
          </Link>

          {/* Activity Timeline Card */}
          <motion.div
            whileHover={{ scale: 1.01 }}
            whileTap={{ scale: 0.99 }}
            className="bg-[#1A1A22]/60 backdrop-blur-xl p-5 rounded-[20px] border border-[#10B981]/10 hover:border-[#10B981]/30 transition-all"
          >
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 bg-[#10B981]/10 rounded-[14px] flex items-center justify-center">
                  <Activity className="w-6 h-6 text-[#10B981]" />
                </div>
                <div>
                  <h3 className="text-white font-semibold">Activity Timeline</h3>
                  <p className="text-[#8A8A92] text-sm">Last 24 hours</p>
                </div>
              </div>
            </div>
            
            {/* Timeline Items */}
            <div className="space-y-3 ml-16">
              {[
                { time: "2 hours ago", text: "Location shared with contacts", status: true },
                { time: "5 hours ago", text: "Safe zone arrival detected", status: true },
                { time: "8 hours ago", text: "Night mode activated", status: true },
              ].map((item, idx) => (
                <div key={idx} className="flex items-start gap-3">
                  <CheckCircle2 className="w-4 h-4 text-[#10B981] mt-0.5" />
                  <div>
                    <p className="text-[#CFCFCF] text-sm">{item.text}</p>
                    <p className="text-[#8A8A92] text-xs mt-0.5">{item.time}</p>
                  </div>
                </div>
              ))}
            </div>
          </motion.div>

          {/* Premium Upgrade Card */}
          <Link to="/premium">
            <motion.div
              whileHover={{ scale: 1.01 }}
              whileTap={{ scale: 0.99 }}
              className="bg-gradient-to-br from-[#D4AF37]/20 to-[#F6D365]/20 backdrop-blur-xl p-5 rounded-[20px] border border-[#D4AF37]/30 hover:border-[#D4AF37]/50 transition-all relative overflow-hidden"
            >
              {/* Glow Effect */}
              <div className="absolute top-0 right-0 w-32 h-32 bg-[#D4AF37]/20 rounded-full blur-2xl" />
              
              <div className="relative flex items-center justify-between">
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 bg-gradient-to-br from-[#D4AF37] to-[#F6D365] rounded-[14px] flex items-center justify-center">
                    <Crown className="w-6 h-6 text-[#0A0A0F]" fill="#0A0A0F" />
                  </div>
                  <div>
                    <h3 className="text-white font-semibold">Upgrade to Premium</h3>
                    <p className="text-[#CFCFCF] text-sm">Unlock all features</p>
                  </div>
                </div>
                <div className="bg-gradient-to-r from-[#D4AF37] to-[#F6D365] text-[#0A0A0F] px-4 py-2 rounded-[12px] font-semibold text-sm">
                  Upgrade
                </div>
              </div>
            </motion.div>
          </Link>
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