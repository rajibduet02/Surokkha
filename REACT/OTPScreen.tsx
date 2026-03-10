import { motion } from "motion/react";
import { Shield, ArrowLeft } from "lucide-react";
import { Link, useNavigate } from "react-router";
import { useState, useRef, useEffect } from "react";

export function OTPScreen() {
  const navigate = useNavigate();
  const [otp, setOtp] = useState(["", "", "", "", "", ""]);
  const [isComplete, setIsComplete] = useState(false);
  const inputRefs = useRef<(HTMLInputElement | null)[]>([]);

  useEffect(() => {
    // Auto-focus first input on mount
    inputRefs.current[0]?.focus();
  }, []);

  useEffect(() => {
    const allFilled = otp.every((digit) => digit !== "");
    setIsComplete(allFilled);
    
    // Auto-submit when complete
    if (allFilled) {
      setTimeout(() => {
        navigate("/profile-type");
      }, 800);
    }
  }, [otp, navigate]);

  const handleChange = (index: number, value: string) => {
    // Only allow single digit
    if (value.length > 1) return;

    // Only allow numbers
    if (value && !/^\d+$/.test(value)) return;

    const newOtp = [...otp];
    newOtp[index] = value;
    setOtp(newOtp);

    // Auto-focus next input
    if (value && index < 5) {
      inputRefs.current[index + 1]?.focus();
    }
  };

  const handleKeyDown = (index: number, e: React.KeyboardEvent) => {
    // Handle backspace
    if (e.key === "Backspace" && !otp[index] && index > 0) {
      inputRefs.current[index - 1]?.focus();
    }
  };

  const handlePaste = (e: React.ClipboardEvent) => {
    e.preventDefault();
    const pastedData = e.clipboardData.getData("text").slice(0, 6);
    
    if (!/^\d+$/.test(pastedData)) return;

    const newOtp = pastedData.split("").concat(Array(6).fill("")).slice(0, 6);
    setOtp(newOtp);

    // Focus last filled input
    const lastFilledIndex = Math.min(pastedData.length, 5);
    inputRefs.current[lastFilledIndex]?.focus();
  };

  return (
    <div className="min-h-screen bg-[#0A0A0F] flex items-center justify-center">
      <div className="w-full max-w-[430px] mx-auto px-8 py-12 flex flex-col items-center justify-between min-h-screen">
        {/* Top Section */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
          className="w-full"
        >
          <Link to="/login">
            <button className="w-10 h-10 bg-[#1A1A22] rounded-[12px] border border-[#D4AF37]/20 flex items-center justify-center mb-8">
              <ArrowLeft className="w-5 h-5 text-[#D4AF37]" />
            </button>
          </Link>

          <div className="flex flex-col items-center">
            {/* Logo */}
            <div className="relative mb-4">
              <motion.div
                animate={{
                  scale: [1, 1.05, 1],
                  opacity: [0.3, 0.4, 0.3],
                }}
                transition={{ duration: 2, repeat: Infinity, ease: "easeInOut" }}
                className="absolute inset-0 bg-[#D4AF37] blur-[40px] rounded-full"
              />
              <Shield className="w-16 h-16 text-[#D4AF37] relative" strokeWidth={1.5} />
            </div>
            <h1 className="text-3xl font-bold text-white mb-2">Verify Code</h1>
            <p className="text-[#8A8A92] text-sm text-center">
              Enter the 6-digit code sent to
            </p>
            <p className="text-[#CFCFCF] text-sm font-medium mt-1">
              +880 1712 345 678
            </p>
          </div>
        </motion.div>

        {/* OTP Input Section */}
        <motion.div
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.2, duration: 0.6 }}
          className="w-full flex-1 flex flex-col justify-center"
        >
          {/* OTP Inputs */}
          <div className="flex items-center justify-center gap-3 mb-8">
            {otp.map((digit, index) => (
              <motion.input
                key={index}
                ref={(el) => (inputRefs.current[index] = el)}
                type="text"
                inputMode="numeric"
                maxLength={1}
                value={digit}
                onChange={(e) => handleChange(index, e.target.value)}
                onKeyDown={(e) => handleKeyDown(index, e)}
                onPaste={index === 0 ? handlePaste : undefined}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.3 + index * 0.05 }}
                className={`w-12 h-12 bg-[#1A1A22] rounded-[16px] border-2 text-center text-xl font-semibold text-white outline-none transition-all duration-300 ${
                  digit
                    ? "border-[#D4AF37] shadow-lg shadow-[#D4AF37]/20"
                    : "border-[#2A2A32]"
                } focus:border-[#D4AF37] focus:shadow-lg focus:shadow-[#D4AF37]/20`}
              />
            ))}
          </div>

          {/* Resend */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ delay: 0.6 }}
            className="text-center space-y-2"
          >
            <p className="text-[#8A8A92] text-sm">Didn't receive the code?</p>
            <button className="text-[#D4AF37] text-sm font-medium hover:underline">
              Resend Code
            </button>
          </motion.div>

          {/* Verification Status */}
          {isComplete && (
            <motion.div
              initial={{ opacity: 0, scale: 0.9 }}
              animate={{ opacity: 1, scale: 1 }}
              className="mt-8 flex items-center justify-center gap-2 text-[#10B981]"
            >
              <motion.div
                animate={{ rotate: 360 }}
                transition={{ duration: 1, ease: "linear" }}
                className="w-5 h-5 border-2 border-[#10B981] border-t-transparent rounded-full"
              />
              <span className="text-sm font-medium">Verifying...</span>
            </motion.div>
          )}
        </motion.div>

        {/* Bottom Section */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4, duration: 0.6 }}
          className="w-full"
        >
          <Link to="/dashboard" className="block">
            <motion.button
              whileHover={{ scale: 1.02 }}
              whileTap={{ scale: 0.98 }}
              disabled={!isComplete}
              className={`w-full font-semibold py-4 rounded-[20px] transition-all duration-300 ${
                isComplete
                  ? "bg-gradient-to-r from-[#D4AF37] to-[#F6D365] text-[#0A0A0F] shadow-lg"
                  : "bg-[#2A2A32] text-[#8A8A92] cursor-not-allowed"
              }`}
            >
              {isComplete ? "Verifying..." : "Verify Code"}
            </motion.button>
          </Link>
        </motion.div>
      </div>
    </div>
  );
}