import { motion } from "motion/react";
import {
  User,
  Crown,
  Shield,
  Bell,
  MapPin,
  Phone,
  Lock,
  HelpCircle,
  LogOut,
  ChevronRight,
  ArrowLeft,
  Settings as SettingsIcon,
  Baby,
} from "lucide-react";
import { Link } from "react-router";
import { FloatingNav } from "../components/FloatingNav";
import { useUser } from "../context/UserContext";

export function ProfileScreen() {
  const { userProfile, isChild, isWoman } = useUser();

  const settingsSections = [
    {
      title: "Account",
      items: [
        { icon: User, label: "Personal Information", badge: null },
        { icon: isChild ? Baby : User, label: "Profile Type", badge: isChild ? "Child" : "Woman", link: "/profile-type" },
        { icon: Crown, label: "Premium Subscription", badge: "Active" },
        { icon: Shield, label: "Privacy & Security", badge: null },
      ],
    },
    {
      title: "Safety Settings",
      items: [
        { icon: Phone, label: "Emergency Contacts", badge: "5" },
        { icon: MapPin, label: "Location Sharing", badge: "On" },
        { icon: Bell, label: "Alert Preferences", badge: null },
      ],
    },
    {
      title: "Support",
      items: [
        { icon: HelpCircle, label: "Help & FAQ", badge: null },
        { icon: SettingsIcon, label: "App Settings", badge: null },
        { icon: LogOut, label: "Sign Out", badge: null, danger: true },
      ],
    },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-b from-[#0A0A0F] via-[#1A1A22] to-[#0A0A0F]">
      <div className="w-full max-w-[430px] mx-auto px-6 py-8 space-y-8 pb-32">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex items-center justify-between"
        >
          <Link to="/dashboard">
            <button className="w-10 h-10 bg-[#1A1A22] rounded-[12px] border border-[#D4AF37]/20 flex items-center justify-center">
              <ArrowLeft className="w-5 h-5 text-[#D4AF37]" />
            </button>
          </Link>
          <h2 className="text-white text-xl font-bold">Profile</h2>
          <Link to="/settings">
            <button className="w-10 h-10 bg-[#1A1A22] rounded-[12px] border border-[#D4AF37]/20 flex items-center justify-center">
              <SettingsIcon className="w-5 h-5 text-[#D4AF37]" />
            </button>
          </Link>
        </motion.div>

        {/* Profile Card */}
        <motion.div
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.1 }}
          className="relative"
        >
          <div className="absolute inset-0 bg-gradient-to-br from-[#D4AF37]/20 to-[#F6D365]/20 rounded-[24px] blur-2xl" />
          <div className="relative bg-gradient-to-br from-[#1A1A22] to-[#2A2A32] p-6 rounded-[24px] border border-[#D4AF37]/30">
            <div className="flex items-center gap-4">
              <div className="relative">
                <div className="w-20 h-20 bg-gradient-to-br from-[#D4AF37] to-[#F6D365] rounded-full flex items-center justify-center">
                  <User className="w-10 h-10 text-[#0A0A0F]" strokeWidth={2} />
                </div>
                <div className="absolute -bottom-1 -right-1 w-7 h-7 bg-[#10B981] rounded-full border-4 border-[#1A1A22] flex items-center justify-center">
                  <Shield className="w-3.5 h-3.5 text-white" />
                </div>
              </div>
              <div className="flex-1">
                <h3 className="text-white text-xl font-bold">Ayesha Rahman</h3>
                <p className="text-[#8A8A92] text-sm">ayesha.r@email.com</p>
                <div className="flex items-center gap-2 mt-2">
                  <Crown className="w-4 h-4 text-[#D4AF37]" fill="#D4AF37" />
                  <span className="text-[#D4AF37] text-sm font-medium">
                    Premium Member
                  </span>
                </div>
              </div>
            </div>
          </div>
        </motion.div>

        {/* Stats */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="grid grid-cols-3 gap-4"
        >
          {[
            { label: "Protected Days", value: "87" },
            { label: "Safe Zones", value: "12" },
            { label: "Check-ins", value: "234" },
          ].map((stat, index) => (
            <motion.div
              key={stat.label}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.3 + index * 0.1 }}
              className="bg-gradient-to-br from-[#1A1A22] to-[#2A2A32] p-4 rounded-[20px] border border-[#D4AF37]/10 text-center"
            >
              <div className="text-[#D4AF37] text-2xl font-bold">
                {stat.value}
              </div>
              <div className="text-[#8A8A92] text-xs mt-1">{stat.label}</div>
            </motion.div>
          ))}
        </motion.div>

        {/* Settings Sections */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
          className="space-y-6"
        >
          {settingsSections.map((section, sectionIndex) => (
            <div key={section.title} className="space-y-3">
              <h3 className="text-[#8A8A92] text-sm font-semibold px-2">
                {section.title}
              </h3>
              <div className="bg-gradient-to-br from-[#1A1A22] to-[#2A2A32] rounded-[20px] border border-[#D4AF37]/10 overflow-hidden">
                {section.items.map((item, index) => {
                  const Component = item.link ? Link : 'button';
                  const linkProps = item.link ? { to: item.link } : {};
                  
                  return (
                    <Component
                      key={item.label}
                      {...linkProps}
                      className={`w-full flex items-center justify-between p-4 transition-all hover:bg-[#2A2A32]/50 ${
                        index !== section.items.length - 1
                          ? "border-b border-[#D4AF37]/5"
                          : ""
                      }`}
                    >
                      <motion.div
                        initial={{ opacity: 0, x: -20 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{
                          delay: 0.5 + sectionIndex * 0.1 + index * 0.05,
                        }}
                        className="flex items-center gap-4"
                      >
                        <div
                          className={`w-10 h-10 rounded-[12px] flex items-center justify-center ${
                            item.danger
                              ? "bg-[#EF4444]/10"
                              : "bg-[#D4AF37]/10"
                          }`}
                        >
                          <item.icon
                            className={`w-5 h-5 ${
                              item.danger ? "text-[#EF4444]" : "text-[#D4AF37]"
                            }`}
                          />
                        </div>
                        <span
                          className={`text-sm font-medium ${
                            item.danger ? "text-[#EF4444]" : "text-white"
                          }`}
                        >
                          {item.label}
                        </span>
                      </motion.div>
                      <div className="flex items-center gap-2">
                        {item.badge && (
                          <div
                            className={`px-2.5 py-1 rounded-full ${
                              item.badge === "Active"
                                ? "bg-[#10B981]/10"
                                : item.badge === "On"
                                ? "bg-[#D4AF37]/10"
                                : item.badge === "Child" || item.badge === "Woman"
                                ? "bg-[#D4AF37]/10"
                                : "bg-[#2A2A32]"
                            }`}
                          >
                            <span
                              className={`text-xs font-medium ${
                                item.badge === "Active"
                                  ? "text-[#10B981]"
                                  : item.badge === "On"
                                  ? "text-[#D4AF37]"
                                  : item.badge === "Child" || item.badge === "Woman"
                                  ? "text-[#D4AF37]"
                                  : "text-[#8A8A92]"
                              }`}
                            >
                              {item.badge}
                            </span>
                          </div>
                        )}
                        {!item.danger && (
                          <ChevronRight className="w-5 h-5 text-[#8A8A92]" />
                        )}
                      </div>
                    </Component>
                  );
                })}
              </div>
            </div>
          ))}
        </motion.div>

        {/* App Version */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.8 }}
          className="text-center pt-4"
        >
          <p className="text-[#8A8A92] text-xs">
            Surokkha v2.1.0
          </p>
          <p className="text-[#8A8A92] text-xs mt-1">
            Made with care for Bangladesh
          </p>
        </motion.div>
      </div>
      <FloatingNav />
    </div>
  );
}