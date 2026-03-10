import { motion } from "motion/react";
import {
  Phone,
  MapPin,
  Users,
  CheckCircle2,
  X,
  Lock,
  Video,
  Camera,
  Shield,
} from "lucide-react";
import { Link } from "react-router";
import { useState } from "react";
import { FloatingNav } from "../components/FloatingNav";
import { useUser } from "../context/UserContext";

export function EmergencyScreen() {
  const [showCancelPIN, setShowCancelPIN] = useState(false);
  const [pin, setPin] = useState("");
  const { isChild, isWoman } = useUser();

  // Different guardians based on profile type
  const guardiansWoman = [
    { name: "Ayesha Rahman", relation: "Mother", status: "Notified", time: "Just now" },
    { name: "Kabir Hossain", relation: "Father", status: "Viewed", time: "2 sec ago" },
    { name: "Nadia Ahmed", relation: "Sister", status: "Notified", time: "Just now" },
    { name: "Dr. Farzana", relation: "Emergency Contact", status: "Notified", time: "Just now" },
    { name: "Police 999", relation: "Authority", status: "Connecting", time: "Just now" },
  ];

  const guardiansChild = [
    { name: "Ayesha Rahman", relation: "Mother", status: "Notified", time: "Just now" },
    { name: "Kabir Hossain", relation: "Father", status: "Viewed", time: "2 sec ago" },
    { name: "Ms. Farzana", relation: "Teacher", status: "Notified", time: "Just now" },
    { name: "Uncle Rashid", relation: "Trusted Adult", status: "Notified", time: "Just now" },
    { name: "Police 999", relation: "Authority", status: "Connecting", time: "Just now" },
  ];

  const guardians = isChild ? guardiansChild : guardiansWoman;

  const handleCancelWithPIN = () => {
    if (pin === "1234") {
      // Navigate back to dashboard
      window.location.href = "/dashboard";
    }
  };

  return (
    <div className="min-h-screen bg-[#0A0A0F] relative">
      {/* Red Glow Overlay */}
      <div className="fixed inset-0 bg-gradient-to-b from-[#EF4444]/10 via-[#EF4444]/5 to-transparent pointer-events-none" />
      <div className="fixed top-0 left-1/2 -translate-x-1/2 w-96 h-96 bg-[#EF4444]/20 rounded-full blur-3xl pointer-events-none" />

      <div className="w-full max-w-[430px] mx-auto px-6 py-8 relative z-10 pb-32">
        <div className="space-y-6">
          {/* Header */}
          <motion.div
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
            className="flex items-center justify-center relative"
          >
            <Link to="/dashboard" className="absolute left-0">
              <button className="w-10 h-10 bg-[#1A1A22] rounded-[12px] border border-[#EF4444]/20 flex items-center justify-center">
                <X className="w-5 h-5 text-[#EF4444]" />
              </button>
            </Link>
            <div className="flex items-center gap-2 bg-gradient-to-r from-[#EF4444]/20 to-[#DC2626]/20 backdrop-blur-sm px-4 py-2 rounded-full border border-[#EF4444]/30">
              <motion.div
                animate={{ scale: [1, 1.2, 1] }}
                transition={{ duration: 1.5, repeat: Infinity }}
                className="w-2 h-2 bg-[#EF4444] rounded-full shadow-[0_0_8px_rgba(239,68,68,0.6)]"
              />
              <span className="text-[#EF4444] text-xs font-bold tracking-wider">
                EMERGENCY ACTIVE
              </span>
            </div>
          </motion.div>

          {/* Status Card */}
          <motion.div
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: 0.1 }}
            className="bg-gradient-to-br from-[#EF4444]/20 to-[#DC2626]/20 backdrop-blur-xl p-6 rounded-[24px] border border-[#EF4444]/30 text-center"
          >
            <motion.div
              animate={{ scale: [1, 1.05, 1] }}
              transition={{ duration: 2, repeat: Infinity }}
              className="inline-flex items-center justify-center w-16 h-16 bg-[#EF4444]/20 rounded-full mb-4"
            >
              <CheckCircle2 className="w-8 h-8 text-[#EF4444]" />
            </motion.div>
            <h2 className="text-white text-2xl font-bold mb-2">
              Emergency Alert Sent
            </h2>
            <p className="text-[#CFCFCF] text-sm">
              Your guardians and authorities have been notified
            </p>
          </motion.div>

          {/* Live Map Preview */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
            className="relative h-48 bg-[#1A1A22] rounded-[20px] border border-[#D4AF37]/20 overflow-hidden"
          >
            {/* Dark Map Style Background */}
            <div className="absolute inset-0 bg-gradient-to-br from-[#1A1A22] to-[#2A2A32]">
              <div className="absolute inset-0 opacity-20">
                {/* Mock map grid */}
                <svg className="w-full h-full" xmlns="http://www.w3.org/2000/svg">
                  <defs>
                    <pattern id="grid" width="20" height="20" patternUnits="userSpaceOnUse">
                      <path d="M 20 0 L 0 0 0 20" fill="none" stroke="#D4AF37" strokeWidth="0.5" opacity="0.3" />
                    </pattern>
                  </defs>
                  <rect width="100%" height="100%" fill="url(#grid)" />
                </svg>
              </div>
            </div>

            {/* Location Marker */}
            <div className="absolute inset-0 flex items-center justify-center">
              {/* Pulsing Radar Rings */}
              <motion.div
                animate={{
                  scale: [1, 2.5, 1],
                  opacity: [0.6, 0, 0.6],
                }}
                transition={{ duration: 2, repeat: Infinity, ease: "easeOut" }}
                className="absolute w-32 h-32 border-4 border-[#EF4444] rounded-full"
              />
              <motion.div
                animate={{
                  scale: [1, 2, 1],
                  opacity: [0.4, 0, 0.4],
                }}
                transition={{ duration: 2, repeat: Infinity, ease: "easeOut", delay: 0.3 }}
                className="absolute w-32 h-32 border-4 border-[#EF4444] rounded-full"
              />
              <motion.div
                animate={{
                  scale: [1, 1.5, 1],
                  opacity: [0.3, 0, 0.3],
                }}
                transition={{ duration: 2, repeat: Infinity, ease: "easeOut", delay: 0.6 }}
                className="absolute w-32 h-32 border-4 border-[#EF4444] rounded-full"
              />
              
              {/* Glow Background */}
              <motion.div
                animate={{
                  scale: [1, 1.2, 1],
                  opacity: [0.4, 0.6, 0.4],
                }}
                transition={{ duration: 2, repeat: Infinity }}
                className="absolute w-24 h-24 bg-[#EF4444] rounded-full blur-2xl"
              />
              
              {/* Realistic Map Pin */}
              <div className="relative z-10">
                {/* Pin Shadow */}
                <div className="absolute top-12 left-1/2 -translate-x-1/2 w-8 h-3 bg-black/40 rounded-full blur-md" />
                
                {/* Pin Body */}
                <motion.div
                  animate={{
                    y: [0, -8, 0],
                  }}
                  transition={{ duration: 2, repeat: Infinity, ease: "easeInOut" }}
                  className="relative"
                >
                  {/* Outer Pin Shape */}
                  <div className="relative w-12 h-12 bg-gradient-to-br from-[#EF4444] to-[#DC2626] rounded-full border-4 border-white shadow-[0_4px_20px_rgba(239,68,68,0.6)] flex items-center justify-center">
                    {/* Inner White Circle */}
                    <div className="w-4 h-4 bg-white rounded-full shadow-inner" />
                    
                    {/* Shine Effect */}
                    <div className="absolute top-1 left-2 w-3 h-3 bg-white/40 rounded-full blur-sm" />
                  </div>
                  
                  {/* Pin Point */}
                  <div className="absolute -bottom-2 left-1/2 -translate-x-1/2 w-0 h-0 border-l-[6px] border-l-transparent border-r-[6px] border-r-transparent border-t-[8px] border-t-[#DC2626]" />
                </motion.div>
              </div>
            </div>

            {/* View Full Map Link */}
            <Link to="/tracking" className="absolute bottom-4 right-4">
              <button className="bg-[#0A0A0F]/80 backdrop-blur-sm px-4 py-2 rounded-[12px] border border-[#D4AF37]/30 text-[#D4AF37] text-xs font-medium">
                View Full Map
              </button>
            </Link>
          </motion.div>

          {/* Evidence Collection Card - Prominent Visual */}
          <Link to="/emergency-recording">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.3 }}
              whileHover={{ scale: 1.02 }}
              whileTap={{ scale: 0.98 }}
              className="bg-gradient-to-br from-[#10B981]/20 to-[#059669]/20 backdrop-blur-xl p-5 rounded-[20px] border border-[#10B981]/30 hover:border-[#10B981]/50 transition-all relative overflow-hidden cursor-pointer mb-6"
            >
              {/* Glow Effect */}
              <div className="absolute top-0 right-0 w-32 h-32 bg-[#10B981]/10 rounded-full blur-2xl pointer-events-none" />
              
              <div className="relative">
                {/* Top Section - Icon and Title */}
                <div className="flex items-start gap-3 mb-3">
                  {/* Icon Group */}
                  <div className="flex-shrink-0">
                    <div className="relative">
                      <div className="w-12 h-12 bg-[#10B981]/20 rounded-[12px] flex items-center justify-center">
                        <Shield className="w-6 h-6 text-[#10B981]" />
                      </div>
                      {/* Recording Badge */}
                      <motion.div
                        animate={{ scale: [1, 1.1, 1] }}
                        transition={{ duration: 2, repeat: Infinity }}
                        className="absolute -top-1 -right-1 w-5 h-5 bg-[#EF4444] rounded-full flex items-center justify-center border-2 border-[#1A1A22]"
                      >
                        <Video className="w-2.5 h-2.5 text-white" />
                      </motion.div>
                    </div>
                  </div>

                  {/* Content */}
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 mb-1">
                      <h3 className="text-white text-base font-bold">
                        Evidence Being Collected
                      </h3>
                      <motion.div
                        animate={{ scale: [1, 1.2, 1] }}
                        transition={{ duration: 1.5, repeat: Infinity }}
                        className="w-2 h-2 bg-[#10B981] rounded-full flex-shrink-0"
                      />
                    </div>
                    <p className="text-[#CFCFCF] text-xs">
                      Auto-recording & encryption active
                    </p>
                  </div>
                </div>
                
                {/* Bottom Section - Status Badges */}
                <div className="flex items-center gap-1.5 pl-[60px]">
                  <div className="flex items-center gap-1 bg-[#10B981]/10 px-2 py-1 rounded-full">
                    <Video className="w-2.5 h-2.5 text-[#10B981]" />
                    <span className="text-[#10B981] text-[10px] font-medium">Recording</span>
                  </div>
                  <div className="flex items-center gap-1 bg-[#10B981]/10 px-2 py-1 rounded-full">
                    <Camera className="w-2.5 h-2.5 text-[#10B981]" />
                    <span className="text-[#10B981] text-[10px] font-medium">Camera</span>
                  </div>
                  <div className="flex items-center gap-1 bg-[#10B981]/10 px-2 py-1 rounded-full">
                    <Lock className="w-2.5 h-2.5 text-[#10B981]" />
                    <span className="text-[#10B981] text-[10px] font-medium">Encrypted</span>
                  </div>
                </div>
              </div>
            </motion.div>
          </Link>

          {/* Action Buttons */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.4 }}
            className="space-y-4"
          >
            {/* Call 999 */}
            <motion.button
              whileTap={{ scale: 0.95 }}
              className="w-full bg-[#1A1A22] border-2 border-[#D4AF37] p-4 rounded-[20px] flex flex-col items-center gap-2 hover:bg-[#2A2A32] transition-all"
            >
              <Phone className="w-6 h-6 text-[#D4AF37]" />
              <span className="text-[#D4AF37] font-semibold text-sm">Call 999</span>
            </motion.button>

          {/* Cancel Button - Separate */}
          
            <motion.button
              whileTap={{ scale: 0.95 }}
              onClick={() => setShowCancelPIN(true)}
              className="w-full bg-[#1A1A22] border border-[#8A8A92]/30 p-4 rounded-[20px] flex items-center justify-center gap-2 hover:bg-[#2A2A32] transition-all"
            >
              <Lock className="w-6 h-6 text-[#8A8A92]" />
              <span className="text-[#8A8A92] font-semibold text-sm">Cancel Emergency (PIN Required)</span>
            </motion.button>
          </motion.div>

          {/* Guardian Notified List */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.4 }}
            className="space-y-3"
          >
            <h3 className="text-white font-semibold text-lg px-2">
              Guardians Notified
            </h3>
            <div className="space-y-2">
              {guardians.map((guardian, idx) => (
                <motion.div
                  key={idx}
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: 0.5 + idx * 0.1 }}
                  className="bg-[#1A1A22]/60 backdrop-blur-xl p-4 rounded-[20px] border border-[#D4AF37]/10 flex items-center justify-between"
                >
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 bg-gradient-to-br from-[#D4AF37] to-[#F6D365] rounded-full flex items-center justify-center">
                      <Users className="w-5 h-5 text-[#0A0A0F]" />
                    </div>
                    <div>
                      <p className="text-white font-medium text-sm">
                        {guardian.name}
                      </p>
                      <p className="text-[#8A8A92] text-xs">{guardian.relation}</p>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className={`flex items-center gap-1.5 ${
                      guardian.status === "Viewed" ? "text-[#10B981]" :
                      guardian.status === "Connecting" ? "text-[#F59E0B]" :
                      "text-[#D4AF37]"
                    }`}>
                      <motion.div
                        animate={{ scale: [1, 1.3, 1] }}
                        transition={{ duration: 1.5, repeat: Infinity }}
                        className={`w-1.5 h-1.5 rounded-full ${
                          guardian.status === "Viewed" ? "bg-[#10B981]" :
                          guardian.status === "Connecting" ? "bg-[#F59E0B]" :
                          "bg-[#D4AF37]"
                        }`}
                      />
                      <span className="text-xs font-medium">{guardian.status}</span>
                    </div>
                    <p className="text-[#8A8A92] text-xs mt-0.5">{guardian.time}</p>
                  </div>
                </motion.div>
              ))}
            </div>
          </motion.div>
        </div>
      </div>

      {/* PIN Modal */}
      {showCancelPIN && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="fixed inset-0 bg-black/80 backdrop-blur-sm z-50 flex items-center justify-center p-6"
          onClick={() => setShowCancelPIN(false)}
        >
          <motion.div
            initial={{ scale: 0.9, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            onClick={(e) => e.stopPropagation()}
            className="w-full max-w-sm bg-[#1A1A22] p-6 rounded-[24px] border border-[#D4AF37]/30"
          >
            <div className="text-center mb-6">
              <Lock className="w-12 h-12 text-[#D4AF37] mx-auto mb-3" />
              <h3 className="text-white text-xl font-bold mb-2">
                Enter PIN to Cancel
              </h3>
              <p className="text-[#8A8A92] text-sm">
                This action requires verification
              </p>
            </div>
            
            <input
              type="password"
              maxLength={4}
              value={pin}
              onChange={(e) => setPin(e.target.value)}
              placeholder="••••"
              className="w-full bg-[#0A0A0F] text-white text-center text-2xl font-bold py-4 rounded-[16px] border-2 border-[#D4AF37]/30 focus:border-[#D4AF37] outline-none mb-4 tracking-widest"
            />

            <div className="grid grid-cols-2 gap-3">
              <button
                onClick={() => setShowCancelPIN(false)}
                className="bg-[#2A2A32] text-white py-3 rounded-[16px] font-semibold"
              >
                Cancel
              </button>
              <button
                onClick={handleCancelWithPIN}
                className="bg-gradient-to-r from-[#D4AF37] to-[#F6D365] text-[#0A0A0F] py-3 rounded-[16px] font-semibold"
              >
                Confirm
              </button>
            </div>
          </motion.div>
        </motion.div>
      )}

      <FloatingNav />
    </div>
  );
}