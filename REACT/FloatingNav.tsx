import { motion } from "motion/react";
import { Home, MapPin, ShieldAlert, Users, User } from "lucide-react";
import { Link, useLocation } from "react-router";

export function FloatingNav() {
  const location = useLocation();

  const navItems = [
    { path: "/dashboard", icon: Home, label: "Home" },
    { path: "/safe-zones", icon: MapPin, label: "Zones" },
    { path: "/emergency", icon: ShieldAlert, label: "SOS" },
    { path: "/contacts", icon: Users, label: "Contacts" },
    { path: "/profile", icon: User, label: "Profile" },
  ];

  const isActive = (path: string) => location.pathname === path;

  return (
    <motion.div
      initial={{ y: 100, opacity: 0 }}
      animate={{ y: 0, opacity: 1 }}
      transition={{ delay: 0.3, duration: 0.3, ease: "easeOut" }}
      className="fixed bottom-6 left-1/2 -translate-x-1/2 z-50"
    >
      <div className="w-[calc(100vw-48px)] max-w-[382px] mx-auto">
        {/* Professional Navigation Bar */}
        <div className="bg-[#1A1A22]/95 backdrop-blur-md rounded-[24px] border border-[#2A2A32] shadow-xl shadow-black/30 px-2 py-2.5">
          <div className="flex items-center justify-between">
            {navItems.map((item) => {
              const Icon = item.icon;
              const active = isActive(item.path);

              return (
                <Link key={item.path} to={item.path}>
                  <motion.button
                    whileTap={{ scale: 0.95 }}
                    transition={{ duration: 0.1 }}
                    className="relative flex flex-col items-center gap-1 px-2 py-1.5"
                  >
                    {/* Active Indicator Background */}
                    {active && (
                      <motion.div
                        layoutId="activeTab"
                        className="absolute inset-0 bg-[#D4AF37]/10 rounded-[16px] border border-[#D4AF37]/30"
                        transition={{ type: "tween", duration: 0.3 }}
                      />
                    )}

                    {/* Icon Container */}
                    <div
                      className={`relative w-10 h-10 rounded-[12px] flex items-center justify-center transition-colors duration-300 ${
                        active
                          ? "bg-gradient-to-br from-[#D4AF37] to-[#F6D365]"
                          : "bg-transparent"
                      }`}
                    >
                      {/* Subtle Glow for SOS Only */}
                      {item.path === "/emergency" && (
                        <div className="absolute inset-0 bg-[#EF4444]/20 rounded-[12px] blur-md" />
                      )}

                      <Icon
                        className={`w-6 h-6 relative z-10 transition-colors ${
                          active
                            ? "text-[#0A0A0F]"
                            : item.path === "/emergency"
                            ? "text-[#EF4444]"
                            : "text-[#8A8A92]"
                        }`}
                        strokeWidth={active ? 2.5 : 2}
                      />
                    </div>

                    {/* Label */}
                    <span
                      className={`text-[10px] font-medium relative z-10 transition-colors ${
                        active
                          ? "text-[#D4AF37]"
                          : item.path === "/emergency"
                          ? "text-[#EF4444]"
                          : "text-[#8A8A92]"
                      }`}
                    >
                      {item.label}
                    </span>
                  </motion.button>
                </Link>
              );
            })}
          </div>
        </div>
      </div>
    </motion.div>
  );
}