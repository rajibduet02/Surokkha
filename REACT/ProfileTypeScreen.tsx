import { motion } from "motion/react";
import { User, Baby, Shield, ArrowRight } from "lucide-react";
import { Link, useNavigate } from "react-router";
import { useUser } from "../context/UserContext";
import { useState } from "react";

export function ProfileTypeScreen() {
  const { setUserProfile } = useUser();
  const navigate = useNavigate();
  const [selectedType, setSelectedType] = useState<"woman" | "child" | null>(null);

  const handleContinue = () => {
    if (selectedType) {
      setUserProfile({
        type: selectedType,
        name: selectedType === "child" ? "Child User" : "Woman User",
      });
      navigate("/dashboard");
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-[#0A0A0F] via-[#0A0A0F] to-[#1A1A22] relative overflow-hidden">
      {/* Ambient Glow */}
      <div className="fixed top-0 left-1/2 -translate-x-1/2 w-96 h-96 bg-[#D4AF37]/10 rounded-full blur-3xl pointer-events-none" />

      <div className="w-full max-w-[430px] mx-auto px-6 py-12 relative z-10">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="space-y-8"
        >
          {/* Header */}
          <div className="text-center space-y-3">
            <motion.div
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ delay: 0.2, type: "spring" }}
              className="w-20 h-20 bg-gradient-to-br from-[#D4AF37] to-[#F6D365] rounded-full mx-auto flex items-center justify-center mb-6"
            >
              <Shield className="w-10 h-10 text-[#0A0A0F]" />
            </motion.div>
            <h1 className="text-white text-3xl font-bold">
              Choose Your Profile
            </h1>
            <p className="text-[#CFCFCF] text-sm max-w-sm mx-auto">
              Select your profile type to personalize your safety experience
            </p>
          </div>

          {/* Profile Type Cards */}
          <div className="space-y-4">
            {/* Woman Profile */}
            <motion.button
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: 0.3 }}
              onClick={() => setSelectedType("woman")}
              className={`w-full p-6 rounded-[24px] border-2 transition-all ${
                selectedType === "woman"
                  ? "bg-gradient-to-br from-[#D4AF37]/20 to-[#F6D365]/20 border-[#D4AF37]"
                  : "bg-[#1A1A22]/60 border-[#D4AF37]/20 hover:border-[#D4AF37]/40"
              }`}
            >
              <div className="flex items-center gap-4">
                <div
                  className={`w-16 h-16 rounded-[16px] flex items-center justify-center transition-all ${
                    selectedType === "woman"
                      ? "bg-gradient-to-br from-[#D4AF37] to-[#F6D365]"
                      : "bg-[#D4AF37]/20"
                  }`}
                >
                  <User
                    className={`w-8 h-8 ${
                      selectedType === "woman" ? "text-[#0A0A0F]" : "text-[#D4AF37]"
                    }`}
                  />
                </div>
                <div className="flex-1 text-left">
                  <h3 className="text-white text-xl font-bold mb-1">Woman</h3>
                  <p className="text-[#CFCFCF] text-xs">
                    Full safety features for adult women
                  </p>
                </div>
                {selectedType === "woman" && (
                  <motion.div
                    initial={{ scale: 0 }}
                    animate={{ scale: 1 }}
                    className="w-6 h-6 bg-[#D4AF37] rounded-full flex items-center justify-center"
                  >
                    <svg className="w-4 h-4 text-[#0A0A0F]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
                    </svg>
                  </motion.div>
                )}
              </div>

              {/* Features */}
              {selectedType === "woman" && (
                <motion.div
                  initial={{ opacity: 0, height: 0 }}
                  animate={{ opacity: 1, height: "auto" }}
                  className="mt-4 pt-4 border-t border-[#D4AF37]/20 space-y-2"
                >
                  <div className="flex items-center gap-2 text-[#D4AF37] text-xs">
                    <div className="w-1.5 h-1.5 bg-[#D4AF37] rounded-full" />
                    <span>Emergency contacts & guardians</span>
                  </div>
                  <div className="flex items-center gap-2 text-[#D4AF37] text-xs">
                    <div className="w-1.5 h-1.5 bg-[#D4AF37] rounded-full" />
                    <span>Workplace & safe zone alerts</span>
                  </div>
                  <div className="flex items-center gap-2 text-[#D4AF37] text-xs">
                    <div className="w-1.5 h-1.5 bg-[#D4AF37] rounded-full" />
                    <span>Real-time location sharing</span>
                  </div>
                </motion.div>
              )}
            </motion.button>

            {/* Child Profile */}
            <motion.button
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: 0.4 }}
              onClick={() => setSelectedType("child")}
              className={`w-full p-6 rounded-[24px] border-2 transition-all ${
                selectedType === "child"
                  ? "bg-gradient-to-br from-[#D4AF37]/20 to-[#F6D365]/20 border-[#D4AF37]"
                  : "bg-[#1A1A22]/60 border-[#D4AF37]/20 hover:border-[#D4AF37]/40"
              }`}
            >
              <div className="flex items-center gap-4">
                <div
                  className={`w-16 h-16 rounded-[16px] flex items-center justify-center transition-all ${
                    selectedType === "child"
                      ? "bg-gradient-to-br from-[#D4AF37] to-[#F6D365]"
                      : "bg-[#D4AF37]/20"
                  }`}
                >
                  <Baby
                    className={`w-8 h-8 ${
                      selectedType === "child" ? "text-[#0A0A0F]" : "text-[#D4AF37]"
                    }`}
                  />
                </div>
                <div className="flex-1 text-left">
                  <h3 className="text-white text-xl font-bold mb-1">Child</h3>
                  <p className="text-[#CFCFCF] text-xs">
                    Simplified safety for children under 18
                  </p>
                </div>
                {selectedType === "child" && (
                  <motion.div
                    initial={{ scale: 0 }}
                    animate={{ scale: 1 }}
                    className="w-6 h-6 bg-[#D4AF37] rounded-full flex items-center justify-center"
                  >
                    <svg className="w-4 h-4 text-[#0A0A0F]" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
                    </svg>
                  </motion.div>
                )}
              </div>

              {/* Features */}
              {selectedType === "child" && (
                <motion.div
                  initial={{ opacity: 0, height: 0 }}
                  animate={{ opacity: 1, height: "auto" }}
                  className="mt-4 pt-4 border-t border-[#D4AF37]/20 space-y-2"
                >
                  <div className="flex items-center gap-2 text-[#D4AF37] text-xs">
                    <div className="w-1.5 h-1.5 bg-[#D4AF37] rounded-full" />
                    <span>Parent & trusted adult contacts</span>
                  </div>
                  <div className="flex items-center gap-2 text-[#D4AF37] text-xs">
                    <div className="w-1.5 h-1.5 bg-[#D4AF37] rounded-full" />
                    <span>School & home safe zones</span>
                  </div>
                  <div className="flex items-center gap-2 text-[#D4AF37] text-xs">
                    <div className="w-1.5 h-1.5 bg-[#D4AF37] rounded-full" />
                    <span>Simple one-tap emergency</span>
                  </div>
                </motion.div>
              )}
            </motion.button>
          </div>

          {/* Continue Button */}
          <motion.button
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.5 }}
            onClick={handleContinue}
            disabled={!selectedType}
            className={`w-full py-4 rounded-[20px] font-bold text-base flex items-center justify-center gap-2 transition-all ${
              selectedType
                ? "bg-gradient-to-r from-[#D4AF37] to-[#F6D365] text-[#0A0A0F] hover:shadow-lg hover:shadow-[#D4AF37]/20"
                : "bg-[#2A2A32] text-[#8A8A92] cursor-not-allowed"
            }`}
          >
            <span>Continue</span>
            <ArrowRight className="w-5 h-5" />
          </motion.button>

          {/* Progress Indicator */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.6 }}
            className="text-center"
          >
            <p className="text-[#8A8A92] text-xs">
              Step 3 of 3 • Setup your profile
            </p>
          </motion.div>
        </motion.div>
      </div>
    </div>
  );
}